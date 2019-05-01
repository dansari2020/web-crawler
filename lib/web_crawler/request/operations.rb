require 'httparty'
require 'nokogiri'

module WebCrawler
  class Request
    module Operations

      def run
        pages_to_crawl = %w( index about contact products ... )
        worker_pool = WebCrawler::Worker.pool(size: 5)
        # If you need to collect the return values check out 'futures'
        pages_to_crawl.each do |page|
          worker_pool.process_page(page)
        end

        # scrape_page(base_url.to_s)
      end

      private

      def scrape_page(url)
        Nokogiri::HTML(HTTParty.get(url))
      end
    end

    def all_links

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