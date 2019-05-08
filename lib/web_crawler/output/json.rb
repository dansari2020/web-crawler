require 'fileutils'
require 'json'
module WebCrawler
  module Output
    class Json
      def initialize(data)
        @data = data
        @path = "#{Dir.pwd}/#{WebCrawler::Config.get('EXPORT_DIR')}/json"
        FileUtils.mkdir_p(@path) unless Dir.exist?(@path)
      end

      def export
        file_name = "#{Time.now.strftime('%Y-%m-%d')}.json"
        json_path = "#{@path}/file_name"
        File.open(json_path, 'w') do |f|
          f.write(@data.to_json)
        end
        json_path
      end
    end
  end
end
