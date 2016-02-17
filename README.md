# ua-tester

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
   -p PROXY_ADDR:PROXY_PORT, --proxy  Set a proxy to use. Default it's disable
   -u, --url                          URL target do scan. Default it's localhost.
   -o, --output			    Set a file to output result scan.
   -b, --browser			    Set a browser template for HTTP Headers, options available are: [firefox, safari and chrome]
   -h, --help			    Print this help message.
 </code>
</pre>

Module to Assist Management of Signature Files \<to newbie :P\>:
<pre>
 <code>
  Usage: uactl [options]

  OPTIONS:
  -a, --enable-all  		Enable all signature files.
  -d, --disable-all              Disable all signature files.
  -l, --list			List all signature files.
  -e, --enable			Enable a unique file.
  -r, --disable			Disable a unique file.
  -h, --help			Print this help message.
 </code>
</pre>

An alternative way is to simply rename the file extension for '.yaml', for example:
 - '<i>cms_joomla.txt</i>' to '<i>cms_joomla.yaml</i>'

<b>Contact:</b>
  - twitter: @ale_menezes

More on <a href="https://github.com/amenezes/ua-tester/wiki">wiki</a>...
