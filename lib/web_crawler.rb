$LOAD_PATH << File.dirname(__FILE__)
require 'byebug'
require 'logger'
require 'colorize'
require 'web_crawler/config'
require 'web_crawler/errors/arg_error'
require './lib/web_crawler/args'
require 'web_crawler/multi_io'
require 'web_crawler/logger'
require 'web_crawler/page_store'
require 'web_crawler/storage'
require 'web_crawler/page'
require 'web_crawler/crawl'
require './lib/web_crawler/output'
require './lib/web_crawler/output/base'
require 'web_crawler/main'

WebCrawler::Args.parse
