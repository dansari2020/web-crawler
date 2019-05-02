module WebCrawler
  class PageStore
    # def_delegators :@storage, :keys, :values, :size, :each

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

    def each_value
      each { |key, value| yield value }
    end

    def values
      result = []
      each { |key, value| result << value }
      result
    end
  end
end
