require 'spec_helper'

RSpec.describe WebCrawler::Args do
  subject(:args) { described_class }
  subject(:config) { WebCrawler::Config }

  it '-e change export' do
    args.parse(['-e', 'html'])
    expect(config.export).to eq('html')
  end

  it '-s change sort by' do
    args.parse(['-s', 'price'])
    expect(config.sort_by).to eq('price')
    config.sort_by = 'name'
  end

  it '-t change sort type' do
    args.parse(['-t', 'desc'])
    expect(config.sort_type).to eq('desc')
    config.sort_type = 'asc'
  end

  it '-p change deep page' do
    args.parse(['-p', '10'])
    expect(config.deep_page).to eq(10)
    config.deep_page = 0
  end
end