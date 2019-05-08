require 'fileutils'
require 'sqlite3'
require 'securerandom'

module WebCrawler
  module Storage
    class SQLite3
      def initialize(file)
        @db = ::SQLite3::Database.new(file)
        FileUtils.mkdir(storage_path.to_s) unless Dir.exist?(storage_path.to_s)
        create_schema
      end

      def [](url)
        uid = @db.get_first_value('SELECT uid FROM storage WHERE url = ?', url.to_s)
        return unless uid
        get_file_as_string(file_path(uid))
      end

      def get_file_as_string(filename)
        return unless File.exist?(filename)
        data = ''
        f = File.open(filename, "r")
        f.each_line do |line|
          data += line
        end
        return data
      end

      def file_path(file_name)
        File.join(storage_path.to_s, file_name)
      end

      def storage_path
        File.join(Config.get('STORAGE_DIR'))
      end

      def []=(url, page_content)
        unless has_url?(url)
          uid = ::SecureRandom.hex
          @db.execute('INSERT INTO storage (url, uid) VALUES(?, ?)', url.to_s, uid)
          open(file_path(uid), 'wb') do |file|
            file << page_content
          end
        end
      end

      def list
        list = []
        @db.execute("SELECT url, uid FROM storage ORDER BY id") do |row|
          page_content = get_file_as_string(file_path(row[1]))
          list << [row[0], page_content]
        end
        list
      end

      def size
        @db.get_first_value('SELECT COUNT(id) FROM storage')
      end

      def urls
        @db.execute("SELECT url FROM storage ORDER BY id").map{|t| t[0]}
      end

      def has_url?(url)
        !!@db.get_first_value('SELECT id FROM storage WHERE url = ?', url.to_s)
      end

      def close
        @db.close
      end

      private

      def create_schema
        @db.execute_batch <<SQL
          create table if not exists storage (
            id INTEGER PRIMARY KEY ASC,
            url TEXT,
            uid VARCHAR
          );
          create index  if not exists web_crawler_url_idx on storage (url);
SQL
      end
    end
  end
end
