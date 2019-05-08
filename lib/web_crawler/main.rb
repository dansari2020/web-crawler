module WebCrawler
  def WebCrawler.crawl(url, opts, &block)
    Main.crawl(url, opts, &block)
  end

  class Main
    attr_reader :pages, :failed_crawls
    attr_accessor :url

    def initialize(url, opts = {})
      @url = @main_url = url
      @opts = opts
      @default_headers = {'content-type'=> ['text/html']}
      uri = URI.parse(url)
      @webpage = "#{uri.scheme}://#{uri.host}"
      Config.deep_page = opts[:deep_page] if opts[:deep_page]
      storage = WebCrawler::Storage.SQLite3
      @pages = PageStore.new(storage)

      WebCrawler::Logger.setting
      @urls = []
      @visited_url = []
      @failed_crawls = []
      @on_every_page_blocks = []

      yield self if block_given?
    end

    def self.crawl(url, opts)
      self.new(url, opts) do |core|
        yield core if block_given?
        core.run
      end
    end

    def run
      WebCrawler::Logger.info "Running web-crawler"
      loop do
        Logger.info ("=" * 100), true
        Logger.info "Craweling #{@url}", true
        content_page = @pages[@url] # fetch from cache local
        unless content_page # fetch from website
          crawl = Crawl.new(@url)
          unless crawl.run
            @failed_crawls << @url
            break if @urls.empty?
            @url = @urls.pop
            next
          end
          @pages[@url] = content_page = crawl.response.body
          headers = crawl.response.to_hash
        end
        page = WebCrawl::Page.new(@url, content_page, headers || @default_headers)

        do_page_blocks page

        found_links = page.links.select { |url| url.start_with?(@webpage) && !ignore_url?(url) }
        @visited_url << @url
        @urls += found_links - @visited_url - @failed_crawls
        @urls.uniq!
        break if @urls.empty?
        @url = @urls.pop
        break if !@opts[:deep_page].nil? && @visited_url.size >= Config.deep_page
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
      wrap(@opts[:ignore_urls]).select { |skip_url| url.start_with?(skip_url) }.size.positive?
    end

    def wrap(object)
      if object.nil?
        []
      elsif object.is_a?(Array)
        object
      else
        [object]
      end
    end
  end
end
