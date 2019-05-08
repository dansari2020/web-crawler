require 'nokogiri'
require 'uri'

module WebCrawl
  class Page
    attr_reader :url
    def initialize(url, body, headers)
      @url = url
      @body = body
      @headers = headers
      @links = []
    end

    def links
      return @links unless @links.nil? || @links.empty?
      return @links unless doc

      doc.search('//a[@href]').each do |a|
        u = a['href']
        next if u.nil? || u.empty? || (u =~ URI::DEFAULT_PARSER.make_regexp).nil?

        @links << path_url(u)
      end
      @links.uniq!
      @links
    end

    def content_type
      @headers['content-type'].first
    end

    def html?
      !!(content_type =~ %r{^(text/html|application/xhtml+xml)\b})
    end

    def doc
      return @doc if @doc

      begin
        @doc = Nokogiri::HTML(@body) if @body && html?
      rescue StandardError
        nil
      end
    end

    def path_url(link)
      "#{URI(link).scheme}://#{URI(link).host}#{URI(link).path}"
    end
  end
end
