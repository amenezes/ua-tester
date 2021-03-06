#!/usr/bin/env ruby
require 'optparse'
require_relative 'scan'
require_relative 'cmd_print'

class UATester

  VERSION="0.3.0"

  def initialize
    @scan = Scan.new
  end

  def print_banner
    CMDPrint.normal("> User-Agent Tester [ua-tester.rb]")
    CMDPrint.version("version: #{VERSION}")
    CMDPrint.blank
  end

  def options_menu
    @options = {}
    optparser = OptionParser.new do |opt|
      opt.banner = print_banner
      opt.separator("")
      opt.separator("OPTIONS:")

      opt.on(
        "-p PROXY_ADDR:PROXY_PORT",
        "--proxy PROXY_ADDR:PROXY_PORT",
        "Set a proxy to use. Default it's disable"
      ) do |proxy_address|
        @options[:proxy] = proxy_address
        @scan.proxy = @options[:proxy]
      end

      opt.on(
        "-u TARGET",
        "--url TARGET",
        "URL target to scan. Default it's <localhost>"
      ) do |target|
        @options[:url] = target
        @scan.uri = @options[:url]
        @scan.start_scan
      end

      opt.on(
        "-o", "--output",
        "Set a <FILE> to output result scan"
      ) do |o|
      end

      opt.on(
        "-b",
        "--browser",
        "Set a browser template for HTTP header, options are: [firefox, safari and chrome]"
      ) do |browser_template|
        @options[:browser] = browser_template
        @scan.browser = @options[:browser]
      end

      opt.on(
        "-h",
        "--help",
        "Print this help message"
      ) do |h|
        CMDPrint.normal(optparser)
        exit
      end
    end
    optparser.parse!
    mandatory = [:url]
    missing = mandatory.select{|param| @options[param].nil?}
    unless missing.empty?
      CMDPrint.normal(optparser)
      exit
    end
  end

  def run
    begin
      options_menu
    rescue => e
      CMDPrint.normal(e.message.capitalize)
      exit 1
    end
  end

end

ua_tester = UATester.new
ua_tester.run
