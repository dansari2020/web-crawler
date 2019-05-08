require 'spec_helper'
require 'vcr_helper'

RSpec.describe WebCrawler::Crawl do
  subject(:crawler) {described_class}

  it '#run' do
    VCR.use_cassette :home do
      @page = crawler.new("http://example.com/foo")
      result = @page.run
      expect(result.body).to eq('Hello')
    end
  end
end