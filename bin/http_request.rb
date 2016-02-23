#!/usr/bin/ruby
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

require 'yaml'
require 'rubygems'
require 'yaml'
require 'typhoeus/adapters/faraday'
require 'faraday'
require 'faraday_middleware'
require_relative 'cmd_print'

class HttpRequest

	DEFAULT_BROWSER="firefox"
	HTTP_HEADER_CONFIG_FILE="#{Dir.pwd}/config/http-header-template.yaml"

	def initialize(browser_template=DEFAULT_BROWSER)
		@http_header_fields = config_http_header browser_template
	end

	def uri(uri)
		Faraday.use(FaradayMiddleware::FollowRedirects)
		@conn = Faraday.new(:url => uri) do |faraday|
			faraday.request :url_encoded
			#faraday.response :logger
			faraday.use FaradayMiddleware::FollowRedirects, limit: 3
			faraday.adapter :typhoeus
		end
	end

	def proxy(addr, port)

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
				req.url uri
				req.options.timeout = 5
				req.options.open_timeout = 5
				req.headers['User-Agent'] = ua_string
			end

			case resp.status
			when 200
				CMDPrint.print_good(ua_string)
			when 401,403,405,406,500,501,502,503,504,505
				CMDPrint.print_error(ua_string)
			end
		rescue Faraday::TimeoutError
			CMDPrint.print_error "#{ua_string}"
		rescue Faraday::ConnectionFailed
			CMDPrint.print_info "couldn't resolve host name."
			exit
		rescue => e
			CMDPrint.print_error e
		end
	end

end
