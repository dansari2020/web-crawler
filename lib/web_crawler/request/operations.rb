require 'httparty'
require 'nokogiri'

module WebCrawler
  class Request
    module Operations

      def run
        scrape_page(base_url.to_s)
      end

      private

      def scrape_page(url)
        Nokogiri::HTML(HTTParty.get(url))
      end
    end

    # def needle
    #   @needle ||= WebCrawler::Pool.get
    # end
    #
    # def get
    #   begin
    #     needle.http_request(
    #         request.base_url.to_s,
    #         request.options.fetch(:method, :get),
    #         sanitize(request.options)
    #     )
    #   rescue Exception => e
    #     raise e.message
    #   end
    #   needle
    # end
  end
end