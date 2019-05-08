require 'spec_helper'

describe WebCrawler do
  describe "get all data" do
    let(:response) { WebCrawler.crawl() }
    # WebCrawler::Request.method(name).call("http://localhost:3001")

    it "returns name" do
      byebug
      expect(response[0][:name]).to eq('Breathe-Easy Tank')
    end
    #
    # unless name == :head
    #   it "makes #{name.to_s.upcase} requests" do
    #     expect(response.response_body).to include("\"REQUEST_METHOD\":\"#{name.to_s.upcase}\"")
    #   end
    # end
  end
end