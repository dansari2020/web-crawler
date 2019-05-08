require 'yaml'
module WebCrawler
  class Config
    class << self
      attr_reader :log, :log_path, :export, :sort_by, :sort_type, :deep_page

      def get(key)
        YAML.load_file('config/config.yml').fetch(key, nil)
      end

      attr_writer :export

      attr_writer :log

      attr_writer :log_path

      attr_writer :sort_by

      def sort_by
        @sort_by || 'name'
      end

      attr_writer :sort_type

      def sort_type
        @sort_type || 'asc'
      end

      def deep_page=(deep_page)
        @deep_page = deep_page.to_s.to_i
      end
    end
  end
end
