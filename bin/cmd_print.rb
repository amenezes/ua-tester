#!/usr/bin/env ruby
module CMDPrint

  def self.good(message)
    puts("\033[00;1;32m[+]\033[0m [ #{message} ]")
  end

  def self.error(message)
    puts("\033[00;1;31m[-]\033[0m [ #{message} ]")
  end

  def self.info(message)
    puts("\033[00;1;34m[*] [ #{message} ]\033[0m")
  end

  def self.debug(message)
    puts("\033[00;1;31m[!] [DEBUG] [ #{message} ]\033[0m")
  end

  def self.version(message)
    puts("\033[4;34m#{message}\033[0m")
  end

end
