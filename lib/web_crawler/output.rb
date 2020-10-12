module WebCrawler
  module Output
    def self.csv(data)
      require_relative 'output/csv'
      WebCrawler::Output::Csv.new(data)
    end

    def self.html(data)
      require_relative 'output/html'
      WebCrawler::Output::Html.new(data)
    end

    def self.json(data)
      require_relative 'output/json'
      WebCrawler::Output::Json.new(data)
    end
  end
end
