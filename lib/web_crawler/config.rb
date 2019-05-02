require 'yaml'
module WebCrawler
  class Config
    class << self
      def get(key)
        YAML.load_file('config/config.yml').fetch(key, nil)
      end
    end
  end
end
