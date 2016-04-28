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

module CMDPrint

	def self.print_good( message )
		puts "\033[00;1;32m[ + ] [ #{ message } ]\033[0m"
	end

	def self.print_error( message )
		puts "\033[00;1;31m[ - ] [ #{ message } ]\033[0m"
	end

	def self.print_info( message )
		puts "\033[00;1;34m[ * ] [ #{ message } ]\033[0m"
	end

	def self.print_debug( message )
		puts "\033[00;1;31m[ * ] [DEBUG] [ #{ message } ]\033[0m"
	end

	def self.print_version( message )
		puts "\033[4;34m#{ message }\033[0m"
	end
end
