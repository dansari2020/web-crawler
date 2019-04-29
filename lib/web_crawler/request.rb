require_relative 'request/actions'
require_relative 'request/operations'
module WebCrawler
  class Request
    extend Request::Actions
    include Request::Operations
    attr_accessor :base_url
    attr_accessor :options
    def initialize(base_url, options = {})
      @base_url = base_url
      @options = options
    end
  end
end