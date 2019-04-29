require 'byebug'
require_relative 'lib/web_crawler'

# WebCrawler::welcome
URL = "http://magento-test.finology.com.my/breathe-easy-tank.html"
result = WebCrawler::get(URL) do |job|
  main = job.xpath('//main').css('div.columns div.column.main')
  extra = main.css('div.product.info.detailed div.product.data.items div#additional div.additional-attributes-wrapper.table-wrapper table#product-attribute-specs-table tbody tr')
  {
      name: main.css('div.product-info-main div.page-title-wrapper.product h1.page-title span.base').text,
      price: main.css('div.product-info-main div.product-info-price div.price-box.price-final_price span.normal-price span.price-container.price-final_price span.price-wrapper').text,
      description: main.css('div.product.info.detailed div.product.data.items div#description div.product,attribute.description div.value p').map(&:text).join("\n"),
      url: "#{URL}",
      extra_information: {
          style: extra[0].css('td.col.data').text,
          material: extra[1].css('td.col.data').text,
          pattern: extra[2].css('td.col.data').text,
          climate: extra[3].css('td.col.data').text,
      }
  }
end
puts result.inspect