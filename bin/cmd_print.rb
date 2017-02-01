#!/usr/bin/env ruby
module CMDPrint

  def self.print_good(message)
    puts("\033[00;1;32m[+] [ #{message} ]\033[0m")
  end

  def self.print_error(message)
    puts("\033[00;1;31m[-] [ #{message} ]\033[0m")
  end

  def self.print_info(message)
    puts("\033[00;1;34m[*] [ #{message} ]\033[0m")
  end

  def self.print_debug(message)
    puts("\033[00;1;31m[!] [DEBUG] [ #{message} ]\033[0m")
  end

  def self.print_version(message)
    puts("\033[4;34m#{message}\033[0m")
  end

end
