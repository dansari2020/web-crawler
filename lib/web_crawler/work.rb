module WebCrawler
  class Work
    def initialize(link_queue, page_queue, opts = {})
      @link_queue = link_queue
      @page_queue = page_queue
      @opts = opts
    end

    def run
      loop do
        link = @link_queue.deq

        break if link == :END

        @http.fetch_pages(link, referer, depth).each { |page| @page_queue << page }


        content_page = @pages[link]
        headers = {'content-type'=> ['text/html']}
        Logger.info "From cache files\r\n" unless content_page.nil?
        unless content_page
          Logger.info "From website\r\n"
          crawl = Crawl.new(@url)
          # byebug
          unless crawl.run
            @visited_url << @url
            @url = @urls.pop
            next
          end
          @pages[@url] = content_page = crawl.response.body
          headers = crawl.response.to_hash
        end
        page = WebCrawl::Page.new(@url, content_page, headers)
        delay
      end
    end
  end
end
