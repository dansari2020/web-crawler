require 'sqlite3'
require 'fileutils' # for creating the directory
require 'byebug' # for creating the directory

module Luma
  class Store
    DIR = "db"
    attr_accessor :db

    def initialize
      FileUtils.mkdir(DIR) unless Dir.exist?(DIR)
      @db = SQLite3::Database.new('db/luma.db')
    end

    def migrate
      create_product_table
      create_extra_table
    end

    def create_product_table
      unless exists_table? "products"
        db.execute <<-SQL
        CREATE TABLE products (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          url VARCHAR,
          name VARCHAR,
          price FLOAT,
          description VARCHAR
        );
        SQL
      end
    end

    def create_extra_table
      unless exists_table? 'extra_informations'
        db.execute <<-SQL
        CREATE TABLE extra_informations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          product_id INTEGER,
          style VARCHAR,
          material VARCHAR,
          pattern VARCHAR,
          climate VARCHAR,
          CONSTRAINT fk_products
            FOREIGN KEY (product_id)
            REFERENCES products(product_id)
            ON DELETE CASCADE
         );
        SQL
      end
    end

    def find_or_create(columns)
      exists?(columns[:name]) || insert(columns)
    end

    def insert(columns)
      db.execute('INSERT INTO products (name, url, price, description) VALUES (?, ?, ?, ?)',
                 [columns[:name], columns[:url], columns[:price], columns[:description]])

      db.execute('INSERT INTO extra_informations (product_id, style, material, pattern, climate) VALUES (?, ?, ?, ?, ?)',
                 [db.last_insert_row_id,
                  columns[:extra_information][:style],
                  columns[:extra_information][:material],
                  columns[:extra_information][:pattern],
                  columns[:extra_information][:climate]]
      )
    end

    def list(order_by = 'name', order_type = 'ASC')
      @list = []
      db.execute( "SELECT id, name, price, description FROM products ORDER BY #{order_by} #{order_type}") do |row|
        product = {
            name: row[1],
            price: row[2],
            description: row[3],
            extra_information: {}
        }
        db.execute( "SELECT style, material, pattern, climate FROM extra_informations where extra_informations.product_id = ?", row[0]) do |extra|
          product[:extra_information] = {
              style: extra[0],
              material: extra[1],
              pattern: extra[2],
              climate: extra[3]
          }
        end
        @list << product
      end
      @list
    end

    def exists?(name)
      query = "SELECT * FROM products WHERE LOWER(name)=?"
      result = db.get_first_row query, name.downcase
      return false if result.nil?
      result
    end

    def exists_table?(table_name)
      query = "SELECT * FROM sqlite_master WHERE type='table' AND name=?"
      result = db.get_first_row query, table_name
      return false if result.nil?
      # Table already exists
      true
    end
  end
end
