module WebCrawler
  def WebCrawler.crawl(url, ignore_urls)
    Main.new(url, ignore_urls).crawl
  end

  class Main
    attr_reader :pages
    attr_accessor :url

    def initialize(url, opts)
      @url = url
      uri = URI.parse(url)
      @webpage = "#{uri.scheme}://#{uri.host}"
      storage = WebCrawler::Storage.SQLite3
      @pages = PageStore.new(storage)
      @opts = opts
      @ignore_urls = opts[:ignore_urls]
      @num_threads = opts[:threads] || 4
      @on_every_page_blocks = []
      WebCrawler::Logger.setting
      @urls = []
      @visited_url = []
      @threads = []
    end

    def crawl
      run
    end

    def run

      WebCrawler::Logger.info "Running web-crawler\r\n"

      link_queue = Queue.new
      page_queue = Queue.new

      @num_threads.times do
        @threads << Thread.new { WebCrawler::Work.new(link_queue, page_queue, @opts).run }
      end

      link_queue.enq(@url)


      loop do
        Logger.info "Craweling #{@url}\r\n"
        WebCrawler::Crawel.new(@url).run
        # content_page = @pages[@url]
        # headers = {'content-type'=> ['text/html']}
        # Logger.info "From cache files\r\n" unless content_page.nil?
        # unless content_page
        #   Logger.info "From website\r\n"
        #   crawl = Crawl.new(@url)
        #   # byebug
        #   unless crawl.run
        #     @visited_url << @url
        #     @url = @urls.pop
        #     next
        #   end
        #   @pages[@url] = content_page = crawl.response.body
        #   headers = crawl.response.to_hash
        # end
        # page = WebCrawl::Page.new(@url, content_page, headers)
        do_page_blocks page
        found_links = page.links.select { |url| url.start_with?(@webpage) && !ignore_url?(url) }

        @visited_url << @url
        # byebug
        @urls += found_links - @visited_url
        @urls.uniq!
        Logger.info "===================\r\n"
        Logger.info "#{@urls.join("\r\n")}"
        Logger.info "size of links: #{@urls.size}\r\n"
        Logger.info "===================\r\n"
        break if @urls.empty?
        @url = @urls.pop
      end
    end

    def on_every_page(&block)
      @on_every_page_blocks << block
      self
    end

    private

    def do_page_blocks(page)
      @on_every_page_blocks.each do |block|
        block.call(page)
      end
    end

    def ignore_url?(url)
      @ignore_urls.select { |skip_url| url.start_with?(skip_url) }.size.positive?
    end
  end
end
