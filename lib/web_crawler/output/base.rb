module WebCrawler
  module Output
    class Base
      def initialize(data, adapter_name)
        @data = data
        @adapter_name = adapter_name || :html
      end

      def adaptor=(adapter_name)
        @adapter_name = adapter_name
      end

      def export
        @adapter = WebCrawler::Output.public_send(@adapter_name, @data)
        path = @adapter.export
        puts "Exported Successfully\r\nPath: #{path}"
      end
    end
  end
end
