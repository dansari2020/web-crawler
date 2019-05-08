require 'json'
module WebCrawler
  module Output
    class Json
      def initialize(data)
        @data = data
      end

      def export
        file_name = "#{Time.now.strftime('%Y-%m-%d')}.json"
        File.open(file_name, 'w') do |f|
          f.write(@data.to_json)
        end
        "#{Dir.pwd}/#{file_name}"
      end
    end
  end
end
