#!/usr/bin/ruby
##
# UA-Tester
# BSecTeam (C) 2015 - 2016
##
require 'optparse'
require_relative 'scan'
require_relative 'cmd_print'

class UATester

  VERSION="0.9.0"

  def initialize
    @scan = Scan.new
  end

  def print_banner
    puts "> User-Agent Tester [ua-tester.rb]"
    CMDPrint.print_version "version: #{ VERSION }"
    puts ""
  end

  def options_menu
    @options = {}
    optparser = OptionParser.new do |opt|
      opt.banner = print_banner
      opt.separator ""
      opt.separator "OPTIONS:"

      opt.on(
        "-p PROXY_ADDR:PROXY_PORT",
        "--proxy PROXY_ADDR:PROXY_PORT",
        "Set a proxy to use. Default it's disable"
      ) do |p|
        @options[:proxy] = p
        @scan.use_proxy( true, @options[:proxy] )
      end

      opt.on(
        "-u TARGET",
        "--url TARGET",
        "URL target to scan. Default it's <localhost>"
      ) do |op|
        @options[:url] = op
        @scan.start_scan @options[:url]
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
      ) do |b|
        @options[:browser] = b
      end

      opt.on(
        "-h",
        "--help",
        "Print this help message"
      ) do |h|
        puts optparser
        exit
      end
    end
    optparser.parse!
    mandatory = [:url]
    missing = mandatory.select{ |param| @options[param].nil? }
    unless missing.empty?
      puts optparser
      exit
    end
  end

  def run
    begin
      options_menu
    rescue => e
      puts e.message.capitalize
      exit 1
     end
  end

end

ua_tester = UATester.new
ua_tester.run
