require 'byebug'
require './lib/web_crawler'
# require_relative 'luma/store'

# store = Luma::Store.new
# store.migrate
URL = "http://magento-test.finology.com.my/breathe-easy-tank.html"
ignore_urls = [
  "http://magento-test.finology.com.my/customer/",
  "http://magento-test.finology.com.my/contact/",
  "http://magento-test.finology.com.my/sendfriend/",
  "http://magento-test.finology.com.my/customer-service/",
  "http://magento-test.finology.com.my/search/term/popular/",
  "http://magento-test.finology.com.my/privacy-policy-cookie-restriction-mode/",
  "http://magento-test.finology.com.my/sales/guest/form/",
  "http://magento-test.finology.com.my/checkout/cart/"
]
# result = WebCrawler::get(URL) do |job|
#   main = job.xpath('//main').css('div.columns div.column.main')
#   extra = main.css('div.product.info.detailed div.product.data.items div#additional div.additional-attributes-wrapper.table-wrapper table#product-attribute-specs-table tbody tr')
#   {
#       name: main.css('div.product-info-main div.page-title-wrapper.product h1.page-title span.base').text,
#       price: main.css('div.product-info-main div.product-info-price div.price-box.price-final_price span.normal-price span.price-container.price-final_price span.price-wrapper').text,
#       description: main.css('div.product.info.detailed div.product.data.items div#description div.product,attribute.description div.value p').map(&:text).join("\n"),
#       url: "#{URL}",
#       extra_information: {
#           style: extra[0].css('td.col.data').text,
#           material: extra[1].css('td.col.data').text,
#           pattern: extra[2].css('td.col.data').text,
#           climate: extra[3].css('td.col.data').text,
#       }
#   }
# end
# result = [
#     {
#         name: 'name',
#         price: '12.00',
#         description: 'description',
#         url: "http://google.com",
#         extra_information: {
#             style: "style",
#             material: "material",
#             pattern: "pattern",
#             climate: "climate",
#         }
#     }
# ]
# result.each do |row|
#   store.find_or_create(row)
# end
# puts result.inspect
# byebug
result = WebCrawler.crawl(URL, ignore_urls)

