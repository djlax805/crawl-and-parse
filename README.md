# covid-19-crawler

If you'd like to help the effort, email coronavirusapi@googlegroups.com
Thanks!

The main code is in crawler.rb. The crawler and parsers are there for the 50
US states and DC. The focus is to collect offical published COVID-19 statistics.
In the bin/ folder are useful commands to run the crawl and parse on all states
or specific ones.

Only the main fields are being captured, so more work is needed to capture additional
fields. Also county data is a big todo item.

The crawled data is being hosted on https://coronavirusapi.com/
That project could also use help!

For Windows users, following is required to get up and running:
Install ruby v2.6.X latest
	For Windows: https://rubyinstaller.org/downloads/
After ruby install, open ruby command line and run for each “gem install <X>” for the gems to install listed below
Gems to install
	Ffi
	Selenium-webdriver
	Nokogiri
	Byebug
Install firefox
Install Visual Studio runtime redist from here:
https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads
Download geckodriver from here:
https://github.com/mozilla/geckodriver/releases
Copy to a location and add to your PATH

Thanks, and stay safe!

## Setting up this repo

- Install [bundle](https://bundler.io/). Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed.
- If bundle is installed, run `bundle install` to install dependencies
- Run `./bin/crawl CA` to run it for California. 
- Run `./bin/crawl_auto` to run it on all the states where everything is automatic. It will skip a few states
that need manual guidance. The script reads `states.csv` which contains a URL to a coronavirus webpage for each state in the USA, including DC. It crawls these webpages and collects the data for each state and saves it in the /data dir.
- Run `ruby parse_log.rb` to collect the data crawled and parsed. It compares the previously scraped data with the current scraped data and saves all the data into `all.csv`.

## Hackathon submission

see https://github.com/coronavirusapi/checkpoint-smart-contracts
