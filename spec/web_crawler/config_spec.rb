require 'spec_helper'

RSpec.describe WebCrawler::Config do
  subject(:config) { described_class }

  it '#default sort_by' do
    expect(config.sort_by).to eq("name")
  end

  it '#default sort_type' do
    expect(config.sort_type).to eq("asc")
  end

  it '#default deep_page' do
    expect(config.deep_page).to eq(0)
  end

  it '#export=' do
    config.export = "html"
    expect(config.export).to eq("html")
  end

  it '#log=' do
    config.log = true
    expect(config.log).to be_truthy
  end
end