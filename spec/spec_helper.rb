$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'bundler'
Bundler.setup
require_relative '../lib/web_crawler'
require 'rspec'
require 'byebug'

RSpec.configure do |config|
end
