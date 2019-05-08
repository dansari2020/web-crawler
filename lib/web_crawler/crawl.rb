require 'net/https'

module WebCrawler
  class Crawl
    attr_reader :link, :response, :code, :response_time

    def initialize(link)
      @link = link
      @body = nil
      @response = nil
      @code = nil
      @response_time = nil
    end

    def run
      @response, @response_time = get_response(link)
      return false unless @response.is_a?(Net::HTTPSuccess)
      @code = Integer(@response.code)
      @response
    end

    def get_response(url)
      start = Time.now()
      escaped_address = URI.escape(url)
      uri = URI.parse(escaped_address)
      response = Net::HTTP.get_response(uri)
      finish = Time.now()
      response_time = ((finish - start) * 1000).round
      return response, response_time
    rescue
      return false, 0
    end
  end
end
