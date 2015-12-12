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
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
##

#!/usr/bin/ruby

require 'yaml'
require 'rubygems'
require 'mechanize'
require_relative 'cmd_print'

class HttpRequest

	DEFAULT_BROWSER="firefox"
	HTTP_HEADER_CONFIG_FILE="#{Dir.pwd}/config/http-header-template.yaml"

	def initialize(browser_template=DEFAULT_BROWSER)
		@http_request = Mechanize.new
		@http_header_fields = config_http_header browser_template
	end

	def uri(uri)
		@http_request.get uri
		@http_request.request_headers = @http_header_fields
		@http_request.read_timeout = 5

		if uri.port == 443
			@http_request.verify_mode = OpenSSL::SSL::VERIFY_NONE
		end
	end

	def proxy(addr, port)
		@http_request.set_proxy addr, port
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
			@http_request.user_agent = ua_string
			res = @http_request.get uri
			case res.code
			when "200"
				CMDPrint.print_good("#{ua_string}")
			when "404","403"
				CMDPrint.print_error("#{ua_string}")
			end
		rescue Net::ReadTimeout
			res = Net::HTTPNotFound.new(nil, 404, nil)
			CMDPrint.print_error("#{ua_string}")
		rescue Timeout::Error
			res = Net::HTTPNotFound.new(nil, 404, nil)
			CMDPrint.print_error("#{ua_string}")
		rescue Errno::ETIMEDOUT
			res = Net::HTTPNotFound.new(nil, 404, nil)
			CMDPrint.print_error("#{ua_string}")
		rescue Net::HTTP::Persistent::Error
			res = Net::HTTPNotFound.new(nil, 404, nil)
			CMDPrint.print_error("#{ua_string}")
		end
	end
end
