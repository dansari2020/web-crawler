require 'spec_helper'
require 'vcr_helper'

describe WebCrawler do
  describe "#crawl" do
    context "when the URL responds successfully" do
      it "crawls websites" do
        VCR.use_cassette :breathe_easy_tank do
          web_page = "http://magento-test.finology.com.my/breathe-easy-tank.html"
          result = WebCrawler.crawl(web_page, {deep_page: 1})

          expect(result.pages.has_url?(web_page)).to be_truthy
        end
      end
    end

    context "when the URL responds failed" do
      it "crawls websites" do
        web_page = "http://failed.com.my"
        result = WebCrawler.crawl(web_page, {deep_page: 1})

        expect(result.pages.has_url?(web_page)).to be_falsey
        expect(result.failed_crawls.size).to eq(1)
        expect(result.failed_crawls[0]).to eq(web_page)
      end
    end
  end
end