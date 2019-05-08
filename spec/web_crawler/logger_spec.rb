require 'spec_helper'

RSpec.describe WebCrawler::Logger do
  it '#info' do
    expect(WebCrawler::Logger.info('return nil')).to be_nil
  end
end