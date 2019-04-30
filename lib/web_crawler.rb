require_relative 'web_crawler/request'

module WebCrawler
  extend Request::Actions
  def self.welcome

    puts 'welcome....'
  end
end
# require 'httparty'
# require 'nokogiri'
#
# class WebCrawler
#   URL = "http://magento-test.finology.com.my/breathe-easy-tank.html"
#   JOBS = []
#
#   def self.get_all_data
#     build_jobs([URL])
#     JOBS
#   end
#
#   private
#
#   def self.scrape_page(url)
#     Nokogiri::HTML(HTTParty.get(url))
#   end
#
#   def self.build_jobs(jobs)
#     jobs.each do |j|
#       page = scrape_page(j)
#       main = page.xpath('//main').css('div.columns div.column.main')
#       job = build_job(main)
#       JOBS << job
#     end
#   end
#
#   def self.build_job(main)
#     {
#         name: main.css('div.product-info-main div.page-title-wrapper.product h1.page-title span.base').text,
#         price: main.css('div.product-info-main div.product-info-price div.price-box.price-final_price span.normal-price span.price-container.price-final_price span.price-wrapper').text,
#         description: main.css('div.product.info.detailed div.product.data.items div#description div.product,attribute.description div.value p').map(&:text).join("\n"),
#         url: "#{URL}",
#         extra_information: {
#             style: main.css('div.product.info.detailed div.product.data.items div#additional div.additional-attributes-wrapper.table-wrapper table#product-attribute-specs-table tbody tr')[0].css('td.col.data').text,
#             material: main.css('div.product.info.detailed div.product.data.items div#additional div.additional-attributes-wrapper.table-wrapper table#product-attribute-specs-table tbody tr')[1].css('td.col.data').text,
#             pattern: main.css('div.product.info.detailed div.product.data.items div#additional div.additional-attributes-wrapper.table-wrapper table#product-attribute-specs-table tbody tr')[2].css('td.col.data').text,
#             climate: main.css('div.product.info.detailed div.product.data.items div#additional div.additional-attributes-wrapper.table-wrapper table#product-attribute-specs-table tbody tr')[3].css('td.col.data').text,
#         }
#     }
#   end
# end