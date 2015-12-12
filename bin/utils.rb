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

class Utils

	attr_accessor :page_result

	def load_signatures_files
		files = Dir.glob("#{Dir.pwd}/signatures/*.yaml")
	end

	def normalize(url)
		if url.start_with? "http://"
		elsif url.start_with? "https://"
		else 
			url = "http://#{url}"
		end
		return URI(url)
	end

	def setting_proxy(params)
		params.split(":")
	end
	
end
