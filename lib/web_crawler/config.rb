require 'yaml'
module WebCrawler
  class Config
    class << self
      attr_accessor :log, :export, :sort_by, :sort_type, :deep_page

      def get(key)
        YAML.load_file('config/config.yml').fetch(key, nil)
      end

      def sort_by
        @sort_by || 'name'
      end

      def sort_type
        @sort_type || 'asc'
      end

      def deep_page
        @deep_page.to_s.to_i
      end
    end
  end
end
