#!/usr/bin/ruby
##
# UA-Tester
# BSecTeam (C) 2015 - 2016
##
require_relative 'utils'
require_relative 'cmd_print'
require_relative 'http_request'

class Scan

  BASE_URL = "http://localhost"
  USE_PROXY = false

  def initialize
    @generic_request = HttpRequest.new
    @utils = Utils.new
    @files = @utils.load_signatures_files
  end

  def use_proxy( use=USE_PROXY, proxy )
    if use
      proxy_params = @utils.setting_proxy proxy
      proxy_addr   = proxy_params[0]
      proxy_port   = proxy_params[1]
      @generic_request.proxy proxy_addr, proxy_port
    end
  end

  def start_scan( url="#{ BASE_URL }" )
    begin
      uri = @utils.normalize url
      @generic_request.uri uri

      @files.each do |file|
        signature_file = YAML.load_file file
        puts "---"
        signature_file.each_key do |ua_class|
          CMDPrint.print_info(ua_class)
          signature_file[ua_class].each do |ua_value|
            res = @generic_request.make_request( uri, ua_value )
          end
        end
      end
      puts ""
    rescue Interrupt
      CMDPrint.print_info "Ctrl + C"
    rescue
      puts $!, $@
      CMDPrint.print_info "Fatal Error!"
     end
  end
end
