# ua-tester <a href="https://codeclimate.com/github/amenezes/ua-tester"><img src="https://codeclimate.com/github/amenezes/ua-tester/badges/gpa.svg" /></a> [![Build Status](https://travis-ci.org/amenezes/ua-tester.svg?branch=master)](https://travis-ci.org/amenezes/ua-tester) [![Dependency Status](https://gemnasium.com/badges/github.com/amenezes/ua-tester.svg)](https://gemnasium.com/github.com/amenezes/ua-tester)


#### Dependencies:
 - Ruby 1.9.3 or above
 - Bundler

#### Installation:
````bash
$ gem install bundler
$ bundle install
````

#### Usage:
````bash
> User-Agent Tester [ua-tester.rb]
version: 0.3.0

Usage: ua-tester [options]

OPTIONS:
    -p PROXY_ADDR:PROXY_PORT,        Set a proxy to use. Default it's disable
        --proxy
    -u, --url TARGET                 URL target to scan. Default it's <localhost>
    -o, --output                     Set a <FILE> to output result scan
    -b, --browser                    Set a browser template for HTTP header, options are: [firefox, safari and chrome]
    -h, --help                       Print this help message
````

Module to Assist Management of Signature Files:
````bash
> User-Agent Tester [signature_controller.rb]
version: 0.3.0

Usage: uactl [options]

OPTIONS:
    -a, --enable-all                 Enable all signature files.
    -d, --disable-all                Disable all signature files.
    -l, --list                       List all signature files.
    -e, --enable <FILE_NAME>         Enable a unique file.
    -r, --disable <FILE_NAME>        Disable a unique file.
    -h, --help                       Print this help message
````

An alternative way is to simply rename the file extension for '.yaml', for example:
````bash
$ mv signature/cms_joomla.txt signature/cms_joomla.yaml
````

#### Contact:
  - twitter: [@ale_menezes](https://twitter.com/ale_menezes)

More on [wiki](https://github.com/amenezes/ua-tester/wiki)...
