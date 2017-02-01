#!/usr/bin/env ruby
require 'optparse'
require_relative 'cmd_print'

class UACtl

  VERSION="0.3.0"

  def list
    files = get_signature_files

    CMDPrint.print_info("valid files to <ua-tester.rb> are")
    files.each do |file|
      CMDPrint.print_good(File.basename(file))
    end
  end

  def disable_all
    CMDPrint.print_info("disabled all signature files...")
    rename_signature_files(".yaml", ".txt")
  end

  def enable_all
    CMDPrint.print_info("enabled all signature files...")
    rename_signature_files(".txt", ".yaml")
  end

  def enable_signature_file(file)
    CMDPrint.print_info("<#{file}> signature enabled.")
    rename_signature_file(file, ".txt", ".yaml")
  end

  def disable_signature_file(file)
    CMDPrint.print_info("<#{file}> signature disabled.")
    rename_signature_file(file, ".yaml", ".txt")
  end

  def print_banner
    puts("> User-Agent Tester [signature_controller.rb]")
    CMDPrint.print_version("version: #{VERSION}")
    puts("")
  end

  def options_menu
    @options = {}
    optparser = OptionParser.new do |opt|
      opt.banner = print_banner
      opt.separator("")
      opt.separator("OPTIONS:")

      opt.on(
        "-a",
        "--enable-all",
        "Enable all signature files."
      ) do |a|
        self.enable_all
        exit
      end

      opt.on(
        "-d",
        "--disable-all",
        "Disable all signature files."
      ) do |d|
        self.disable_all
        exit
      end

      opt.on(
        "-l",
        "--list",
        "List all signature files."
      ) do |l|
        self.list
        exit
      end

      opt.on(
        "-e",
        "--enable <FILE_NAME>",
        "Enable a unique file."
      ) do |e|
        self.enable_signature_file(e)
      end

      opt.on(
        "-r",
        "--disable <FILE_NAME>",
        "Disable a unique file."
      ) do |r|
        self.disable_signature_file(r)
      end

      opt.on(
        "-h",
        "--help",
        "Print this help message"
      ) do |h|
        puts(optparser)
        exit
      end
    end
    optparser.parse!
  end

  def run
    begin
      options_menu
    rescue => e
      puts(e.message.capitalize)
      exit 1
    end
  end

  private

  def rename_signature_files(
    fbase_extension,
    fdest_extension,
    files=get_signature_files
  )
    files.each do |file|
      if (File.extname(file)).end_with?"#{fbase_extension}"
        File.rename(
          "signatures/#{File.basename(file)}",
          "signatures/#{File.basename(file,
          "#{fbase_extension}")
            .concat("#{fdest_extension}")}"
        )
      end
    end
  end

  def rename_signature_file(file, old_extension, new_extension)
    test_file(file, new_extension)
    rename_signature_files(
      old_extension,
      new_extension,
      get_signature_files(
        "#{Dir.pwd}/signatures/#{ file }*.{yaml,txt}"
      )
    )
  end

  def get_signature_files(
    signature_directory = "#{Dir.pwd}/signatures/*.{yaml,txt}"
  )
    Dir.glob(signature_directory)
  end

  def test_file(file, extension)
    if ((File.extname file) == extension)
      CMDPrint.print_info("seems that are nothing to do with signature file set <#{file}>.")
      exit
    elsif File.exist?File.expand_path(file + extension, "signatures")
      CMDPrint.print_info("signature specify already enabled or disabled!")
      exit
    end
  end

end

ua = UACtl.new
ua.run
