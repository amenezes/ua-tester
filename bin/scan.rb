##
# UA-Tester
#
# Copyright (C) 2015 - 2016 - BSecTeam
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
