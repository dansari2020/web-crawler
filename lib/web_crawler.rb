$LOAD_PATH << File.dirname(__FILE__)

require "http"
require "nokogiri"
require "logger"
require "colorize"

require "web_crawler/version"

require "web_crawler/main"
require "web_crawler/file"
require "web_crawler/logger"
require "web_crawler/multi_io"
require "web_crawler/config"

# parser
require "web_crawler/parser/args"
require "web_crawler/parser/base"
require "web_crawler/parser/html"
require "web_crawler/parser/json"

# error
require "web_crawler/errors/http_error"
require "web_crawler/errors/env_error"
require "web_crawler/errors/arg_error"