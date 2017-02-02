#!/usr/bin/env ruby
require 'rubygems'
require 'yaml'
require 'typhoeus/adapters/faraday'
require 'faraday'
require 'faraday_middleware'
require_relative 'cmd_print'

class HttpRequest

  attr_accessor :proxy_addr
  DEFAULT_BROWSER = "firefox"
  HTTP_HEADER_CONFIG_FILE = "#{Dir.pwd}/config/http-header-template.yaml"

  def proxy_addr
    @proxy_addr || ''
  end

  def initialize(browser_template=DEFAULT_BROWSER)
    @http_header_fields = config_http_header(browser_template)
  end

  def uri(uri)
    Faraday.use(FaradayMiddleware::FollowRedirects)
      @conn = Faraday.new(:url => uri) do |faraday|
        faraday.request(:url_encoded)
        faraday.use(FaradayMiddleware::FollowRedirects, limit: 3)
        faraday.adapter(:typhoeus)
        faraday.proxy(@proxy_addr)
      end
  end

  def config_http_header(browser_template)
    http_header = {}
    http_fields = YAML.load_file(HTTP_HEADER_CONFIG_FILE)
    http_fields[browser_template].each do |key,value|
      http_header.store("#{key}", "#{value}")
    end
    return http_header
  end

  def make_request(uri, ua_string)
    begin
      resp = @conn.get do |req|
        req.url(uri)
        req.options.timeout = 5
        req.options.open_timeout  = 5
        req.headers['User-Agent'] = ua_string
      end

      case resp.status
      when 200
        CMDPrint.good(ua_string)
      when 400..505
        CMDPrint.error(ua_string)
      end

      rescue Faraday::TimeoutError
        CMDPrint.error("#{ua_string}")
      rescue Faraday::ConnectionFailed
        CMDPrint.info("couldn't resolve hostname.")
        exit
      rescue => e
        CMDPrint.error(e)
      end
  end

end
