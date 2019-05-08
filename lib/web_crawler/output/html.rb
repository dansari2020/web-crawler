require 'erb'
module WebCrawler
  module Output
    class Html
      def initialize(data)
        @data = data
      end

      def export
        file_name = "#{Time.now.strftime('%Y-%m-%d')}.html"
        template = File.read('lib/web_crawler/output/template/list.html.erb')
        result = ERB.new(template).result(binding)
        File.open(file_name, 'w+') do |f|
          f.write result
        end
        "#{Dir.pwd}/#{file_name}"
      end
    end
  end
end
