##
# UA-Tester
#
# Copyright (C) 2015 - 2015 - BSecTeam
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public Licens
##

#!/usr/bin/ruby

require 'optparse'
require_relative 'cmd_print'

class UACtl

  VERSION="0.1"

  def list
    files = Dir.glob("#{Dir.pwd}/signatures/*.{yaml,txt}")
    CMDPrint.print_info "valid files to <ua-tester.rb> are"
    files.each do |file|
      CMDPrint.print_good File.basename file
    end
  end

  def disable_all
    CMDPrint.print_info "disabled all signature files..."

    files = Dir.glob("#{Dir.pwd}/signatures/*.{yaml,txt}")
    files.each do |file|
      if (File.extname file).end_with?".yaml"
        File.rename(
          "signatures/#{File.basename(file)}",
          "signatures/#{File.basename(file, ".yaml").concat(".txt")}"
        )
      end
    end
  end

  def enable_all
    CMDPrint.print_info "enabled all signature files..."

    files = Dir.glob("#{Dir.pwd}/signatures/*.{yaml,txt}")
    files.each do |file|
      if (File.extname file).end_with?".txt"
        File.rename(
          "signatures/#{File.basename(file)}",
          "signatures/#{File.basename(file, ".txt").concat(".yaml")}"
        )
      end
    end
  end

  def enable_sig file
  end

  def print_banner
    puts "> User-Agent Tester [signature_controller.rb]"
    CMDPrint.print_version "version: #{VERSION}"
    puts ""
  end

  def options_menu
    @options = {}
		optparser = OptionParser.new do |opt|
			opt.banner = print_banner
			opt.separator ""
			opt.separator "OPTIONS:"

			opt.on("-a", "--enable-all", "Enable all signature files.") do |a|
        self.enable_all
        exit
			end

			opt.on("-d", "--disable-all", "Disable all signature files.") do |d|
        self.disable_all
        exit
			end

			opt.on("-l", "--list", "List all signature files.") do |l|
        self.list
        exit
			end

			opt.on("-e", "--enable <FILE_NAME>", "Enable a unique file.") do |e|
				#@options[:en_signature_file] = e
			end

			opt.on("-h", "--help", "Print this help message") do |h|
				puts optparser
				exit
			end
		end

    optparser.parse!

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

ua = UACtl.new
ua.run
