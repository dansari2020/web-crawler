require 'nokogiri'
require 'uri'

module WebCrawl
  class Page
    def initialize(url, body, headers)
      @url = url
      @body = body
      @headers = headers
      @links = []
    end

    def links
      return @links unless @links.nil? || @links.empty?
      return @links if !doc
      doc.search("//a[@href]").each do |a|
        u = a['href']
        next if u.nil? || u.empty? || (u =~ URI::regexp).nil?
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
      @doc = Nokogiri::HTML(@body) if @body && html? rescue nil
    end

    def path_url(link)
      "#{URI(link).scheme}://#{URI(link).host}#{URI(link).path}"
    end
  end
end
