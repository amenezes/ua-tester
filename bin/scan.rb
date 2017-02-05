#!/usr/bin/env ruby
require 'uri'
require 'yaml'
require 'typhoeus'
require_relative 'cmd_print'

class Scan

  attr_accessor :proxy
  attr_accessor :uri

  def initialize
    @http_headers = config_default_headers
    @hydra = Typhoeus::Hydra.new
    @requests_controll = {}
  end

  def proxy
    @proxy || ''
  end

  def uri
    @uri || 'localhost'
  end

  def start_scan
    begin
      prepare_request(uri, proxy)
      signatures = load_signature
      signatures.each do |sig_file|
        prepare_category(sig_file)
      end
    CMDPrint.blank
    rescue Interrupt
      CMDPrint.info("Ctrl + C")
    rescue
      puts $!, $@
      CMDPrint.info("Fatal Error!")
    end
  end

  def prepare_category(sig_file)
    sig_file.each_key do |ua_class|
      CMDPrint.info(ua_class)
      request_inside(sig_file, ua_class)
      @hydra.run
      print_output
    end
  end

  def request_inside(sig_file, ua_class)
    sig_file[ua_class].each do |ua_value|
      @http_headers['User-Agent'] = ua_value
      request = make_request(@uri, @proxy, @http_headers)
      @requests_controll[ua_value] = request
      @hydra.queue(request)
    end
  end

  def load_signature
    signatures = []
    files_enabled = Dir.glob("#{Dir.pwd}/signatures/*yaml")
    files_enabled.each do |file|
      signatures << YAML.load_file(file)
    end
    return signatures
  end

  private

  def print_output()
    @requests_controll.each do |user_agent , request|
      response_code = request.response.response_code
      case response_code
      when 200
        CMDPrint.good(user_agent)
      else
        CMDPrint.error(user_agent)
      end
    end
    @requests_controll = {}
  end

  def prepare_request(uri, proxy)
    unless proxy.empty?
      @proxy = normalize_uri(proxy)
    end
    @uri = normalize_uri(uri)
  end

  def normalize_uri(url)
    unless (url.start_with?("http://") || url.start_with?("https://"))
      url = "http://#{url}"
    end
    return URI(url)
  end

  def config_default_headers(browser_template='firefox')
    http_headers = {}
    http_fields = YAML.load_file("#{Dir.pwd}/config/http-header-template.yaml")
    http_fields[browser_template].each do |key,value|
      http_headers.store("#{key}", "#{value}")
    end
    return http_headers
  end

  def make_request(uri, proxy, custom_headers={})
    request = Typhoeus::Request.new(
        uri,
        followlocation: true,
        timeout: 5,
        accept_encoding: "gzip",
        ssl_verifypeer: false,
        headers:
          custom_headers.each do |header_name,header_value|
            {header_name => header_value}
          end
      )
      return request
  end

end
