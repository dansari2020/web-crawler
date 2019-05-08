require 'byebug'
require_relative '../lib/web_crawler'
require_relative 'store'

module Luma
  class Main
    URL = 'http://magento-test.finology.com.my/breathe-easy-tank.html'.freeze

    def initialize
      @store = Luma::Store.new
      @store.migrate
      @options = {
        deep_page: WebCrawler::Config.deep_page || 20,
        ignore_urls: [
          'http://magento-test.finology.com.my/customer/',
          'http://magento-test.finology.com.my/contact/',
          'http://magento-test.finology.com.my/sendfriend/',
          'http://magento-test.finology.com.my/customer-service/',
          'http://magento-test.finology.com.my/search/term/popular/',
          'http://magento-test.finology.com.my/privacy-policy-cookie-restriction-mode/',
          'http://magento-test.finology.com.my/sales/guest/form/',
          'http://magento-test.finology.com.my/checkout/cart/',
          'http://magento-test.finology.com.my/about-us/'
        ]
      }
    end

    def log(row)
      log_extra = [
        "Style: #{row[:extra_information][:style]}",
        "Material: #{row[:extra_information][:material]}",
        "Pattern: #{row[:extra_information][:pattern]}",
        "Climate: #{row[:extra_information][:climate]}"
      ]
      log_product = [
        "Name: #{row[:name]}",
        "Price: #{row[:price]}",
        "Description: #{row[:description]}",
        "Extra information: #{log_extra.join(' | ')}"
      ]
      WebCrawler::Logger.info log_product.join("\r\n")
    end

    def parse
      result = WebCrawler.crawl(URL, @options) do |main|
        main.on_every_page do |page|
          doc = page.doc
          next if doc.css('body.catalog-product-view').empty?

          main = doc.xpath('//main').css('div.columns div.column.main')
          extra = main.css('div.product.info.detailed div.product.data.items div#additional div.additional-attributes-wrapper.table-wrapper '\
              'table#product-attribute-specs-table tbody tr')
          row = {
            name: main.css('div.product-info-main div.page-title-wrapper.product h1.page-title span.base').text,
            price: main.css('div.product-info-main div.product-info-price div.price-box.price-final_price span.normal-price '\
              'span.price-container.price-final_price span.price-wrapper').text,
            description: main.css('div.product.info.detailed div.product.data.items div#description div.product.attribute.description '\
              'div.value p').map(&:text).join("\n"),
            url: page.url,
            extra_information: {
              style: extra[0].css('td.col.data').text,
              material: extra[1].css('td.col.data').text,
              pattern: extra[2].css('td.col.data').text,
              climate: extra[3].css('td.col.data').text
            }
          }
          log(row)
          @store.find_or_create(row)
        end
      end
      WebCrawler::Logger.info '=' * 100
      WebCrawler::Logger.info "Time: #{result.crawled_times} seconds"
      WebCrawler::Logger.info '=' * 100
      do_export if WebCrawler::Config.export
    end

    def do_export
      data = @store.list(WebCrawler::Config.sort_by, WebCrawler::Config.sort_type)
      output = WebCrawler::Output::Base.new(data, WebCrawler::Config.export)
      output.export
    end
  end
end

Luma::Main.new.parse
