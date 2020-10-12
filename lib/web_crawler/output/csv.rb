require 'fileutils'
require 'csv'
module WebCrawler
  module Output
    class Csv
      def initialize(data)
        @data = data
        @path = "#{Dir.pwd}/#{WebCrawler::Config.get('EXPORT_DIR')}/csv"
        FileUtils.mkdir_p(@path) unless Dir.exist?(@path)
      end

      def export
        file_name = "#{Time.now.strftime('%Y-%m-%d')}.csv"
        csv_path = "#{@path}/#{file_name}"
        CSV.open(csv_path, 'w') do |csv|
          csv << ['Name', 'Price', 'Description', 'Extra Information']
          @data.each do |item|
            csv << [item[:name], item[:price], item[:description], extra(item[:extra_information])]
          end
        end
        csv_path
      end

      private

      def extra(extra)
        [
          "Style: #{extra[:style]}",
          "Material: #{extra[:material]}",
          "Pattern: #{extra[:pattern]}",
          "Climate: #{extra[:climate]}"
        ].join(' | ')
      end
    end
  end
end
