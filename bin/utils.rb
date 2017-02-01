#!/usr/bin/env ruby
require 'uri'

class Utils

  attr_accessor :page_result

  def load_signatures_files
    Dir.glob("#{Dir.pwd}/signatures/*.yaml")
  end

  def normalize(url)
    unless (url.start_with?("http://") || url.start_with?("https://"))
      url = "http://#{url}"
    end
    return URI(url)
  end

  def setting_proxy(params)
    params.split(":")
  end

end
