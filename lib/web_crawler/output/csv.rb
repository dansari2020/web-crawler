require 'csv'
module WebCrawler
  module Output
    class Csv
      def initialize(data)
        @data = data
      end

      def export
        file_name = "#{Time.now.strftime('%Y-%m-%d')}.csv"
        CSV.open(file_name, "w") do |csv|
          csv << ["Name", "Price", "Description", "Extra Information"]
          @data.each do |item|
            csv << [item[:name], item[:price], item[:description], extra(item[:extra_information])]
          end
        end
        "#{Dir.pwd}/#{file_name}"
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
