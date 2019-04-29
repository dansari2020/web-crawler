module WebCrawler
  class Request
    module Actions
      def get(base_url, options = {})
        response = Request.new(base_url, options.merge(:method => :get)).run
        yield(response)
      end
    end
  end
end