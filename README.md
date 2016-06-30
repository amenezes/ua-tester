# ua-tester <a href="https://codeclimate.com/github/amenezes/ua-tester"><img src="https://codeclimate.com/github/amenezes/ua-tester/badges/gpa.svg" /></a> [![Build Status](https://travis-ci.org/amenezes/ua-tester.svg?branch=master)](https://travis-ci.org/amenezes/ua-tester)

<b>Dependencies:</b>
 - Ruby: http://www.ruby-lang.org
  - minimum version 1.9.3
 - OptionParser: https://rubygems.org/gems/OptionParser
 - RequireRelative: http://www.steveklabnik.com/require_relative/
 - Faraday: https://github.com/lostisland/faraday
 - Typhoeus: https://github.com/typhoeus/typhoeus
 - Faraday_middleware: https://github.com/lostisland/faraday_middleware
 - Bundler: http://bundler.io

<b>Installation:</b>
- <i>bundle install</i>

<b>Usage:</b>
<pre>
 <code>
  Usage: ua-tester [options]

  OPTIONS:
   -p PROXY_ADDR:PROXY_PORT, --proxy &#9; Set a proxy to use. Default it's disable
   -u, --url &#9;&#9;&#9;&#9; URL target do scan. Default it's localhost.
   -o, --output &#9;&#9;&#9; Set a file to output result scan.
   -b, --browser &#9;&#9;&#9; Set a browser template for HTTP Headers, options available are: [firefox, safari and chrome]
   -h, --help &#9;&#9;&#9;&#9; Print this help message.
 </code>
</pre>

Module to Assist Management of Signature Files \<to newbie :P\>:
<pre>
 <code>
  Usage: uactl [options]

  OPTIONS:
  -a, --enable-all &#9;&#9; Enable all signature files.
  -d, --disable-all &#9;&#9; Disable all signature files.
  -l, --list &#9;&#9;&#9; List all signature files.
  -e, --enable &#9;&#9;&#9; Enable a unique file.
  -r, --disable &#9;&#9; Disable a unique file.
  -h, --help &#9;&#9;&#9; Print this help message.
 </code>
</pre>

An alternative way is to simply rename the file extension for '.yaml', for example:
 - '<i>cms_joomla.txt</i>' to '<i>cms_joomla.yaml</i>'

<b>Contact:</b>
  - twitter: @ale_menezes

More on <a href="https://github.com/amenezes/ua-tester/wiki">wiki</a>...
