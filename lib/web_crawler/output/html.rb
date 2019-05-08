require 'fileutils'
require 'erb'
module WebCrawler
  module Output
    class Html
      def initialize(data)
        @data = data
        @path = "#{Dir.pwd}/#{WebCrawler::Config.get('EXPORT_DIR')}/html"
        FileUtils.mkdir_p(@path) unless Dir.exist?(@path)
      end

      def export
        file_name = "#{Time.now.strftime('%Y-%m-%d')}.html"
        html_path = "#{@path}/#{file_name}"
        template = File.read('lib/web_crawler/output/template/list.html.erb')
        result = ERB.new(template).result(binding)
        File.open(html_path, 'w+') do |f|
          f.write result
        end
        html_path
      end
    end
  end
end
