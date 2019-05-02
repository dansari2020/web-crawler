# require 'thread'
require 'byebug'
require 'uri'

# work = Queue.new

# byebug
# producer = Thread.new do
#   count = 0
#   loop do
#     sleep 1 # some work done by the producer
#     count += 1
#     puts "queuing job #{count}"
#     work << "job #{count}"
#   end
# end


# consumer = Thread.new do
#   loop do
#     job = work.deq
#     puts "worker: #{job}"

#     # some more long running job
#     sleep 2
#   end
# end
# sleep 12
link = "http://magento-test.finology.com.my/promotions/men-sale.html?climate=212&eco_collection=0&erin_recommends=0&material=38&new=0&pattern=197&performance_fabric=0&sale=1&size=179&style_bottom=116
"
byebug
link = URI.encode(URI.decode(link.to_s.gsub(/#[a-zA-Z0-9_-]*$/,'')))

relative = URI(link)
# absolute = base ? base.merge(relative) : @url.merge(relative)
