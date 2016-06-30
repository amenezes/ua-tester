#!/usr/bin/ruby
##
# UA-Tester
# BSecTeam (C) 2015 - 2016
##
require 'uri'

class Utils

  attr_accessor :page_result

  def load_signatures_files
    Dir.glob("#{Dir.pwd}/signatures/*.yaml")
  end

  def normalize(url)
    if url.start_with?("http://")
      elsif url.start_with?("https://")
      else
        url = "http://#{url}"
      end
      return URI(url)
  end

  def setting_proxy( params )
    params.split( ":" )
  end

end
