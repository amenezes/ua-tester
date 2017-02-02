#!/usr/bin/env ruby
require_relative 'utils'
require_relative 'cmd_print'
require_relative 'http_request'

class Scan

  attr_accessor :proxy
  BASE_URL = "http://localhost"

  def initialize
    @generic_request = HttpRequest.new
    @utils = Utils.new
    @files = @utils.load_signatures_files
  end

  def proxy
    @proxy || ''
  end

  def start_scan(url="#{BASE_URL}")
    begin
      unless proxy.empty?
        @proxy = @utils.normalize(proxy)
      end

      uri = @utils.normalize(url)
      @generic_request.proxy_addr = @proxy
      @generic_request.uri(uri)

      @files.each do |file|
        signature_file = YAML.load_file file
        puts("---")
        signature_file.each_key do |ua_class|
          CMDPrint.info(ua_class)
          signature_file[ua_class].each do |ua_value|
            res = @generic_request.make_request(uri, ua_value)
          end
        end
      end
      puts("")
    rescue Interrupt
      CMDPrint.info("Ctrl + C")
    rescue
      puts $!, $@
      CMDPrint.info("Fatal Error!")
    end
  end

  def set_proxy(proxy)
    unless proxy.empty?
      proxy_addr = @utils.normalize(proxy)
      @generic_request.proxy = proxy_addr
      #@generic_request.set_proxy(proxy_addr)
    end
  end

end
