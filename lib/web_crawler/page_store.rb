module WebCrawler
  class PageStore
    def initialize(storage = {})
      @storage = storage
    end

    def [](index)
      @storage[index.to_s]
    end

    def []=(index, body)
      @storage[index.to_s] = body
    end

    def has_url?(key)
      @storage.has_url? key.to_s
    end

    def on_every_page
      @storage.list.each do |url, doc|
        yield url, doc
      end
    end
  end
end
