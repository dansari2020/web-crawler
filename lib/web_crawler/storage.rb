require 'fileutils'
require 'web_crawler/storage/sqlite3'

module WebCrawler
  module Storage
    def self.SQLite3(file = 'web_crawler.db')
      FileUtils.mkdir(Config.get('DB_DIR')) unless Dir.exist?(Config.get('DB_DIR'))
      self::SQLite3.new("#{Config.get('DB_DIR')}/#{file}")
    end
  end
end
