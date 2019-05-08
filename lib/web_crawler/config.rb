require 'yaml'
module WebCrawler
  class Config
    class << self
      attr_reader :log, :log_path, :export, :sort_by, :sort_type

      def get(key)
        YAML.load_file('config/config.yml').fetch(key, nil)
      end

      def export=(export)
        @export = export
      end

      def log=(log)
        @log = log
      end

      def log_path=(log_path)
        @log_path = log_path
      end

      def sort_by=(sort_by)
        @sort_by = sort_by
      end

      def sort_by
        @sort_by || 'name'
      end

      def sort_type=(sort_type)
        @sort_type = sort_type
      end

      def sort_type
        @sort_type || 'asc'
      end
    end
  end
end
