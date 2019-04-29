require 'sqlite3'

db = SQLite3::Database.new('../../db/web_crawler.db')

rows = db.execute <<-SQL
          create table products(
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           url VARCHAR,
           name VARCHAR,
           price INTEGER,
           description VARCHAR
         );
          create table extra_informations(
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

puts rows
puts rows.inspect
