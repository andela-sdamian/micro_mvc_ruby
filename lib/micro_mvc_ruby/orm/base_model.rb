require_relative 'db_helper'
require_relative 'query_helper'
require_relative 'database'
require 'sqlite3'

module MicroMvcRuby
  class BaseModel 
    extend MicroMvcRuby::DbHelper
    include MicroMvcRuby::QueryHelper

    def table_name
      self.class.table_name
    end

    def save
      if id
        Database.execute("
          UPDATE #{table_name} SET #{update_table_placeholders}
          WHERE id = ? ", update_records)
      else
        Database.execute("
          INSERT INTO #{table_name} (#{table_columns})
          VALUES (#{new_table_placeholders})
          ", new_record_value)
      end
    end

    alias save! save

    def update(params)
      Database.execute("UPDATE #{table_name}
      SET #{update_record_placeholders(params)}
      WHERE id=?", update_values(params))
    end

    def destroy
      Database.execute("DELETE FROM #{table_name} WHERE id = ?", id)
    end

    def self.find_by(params)
      key = params.keys[0].to_s
      value = params.values[0].to_s
      row = Database.execute("SELECT #{column_keys} FROM #{table_name}
            WHERE #{key} = ? ", value).first

      map_row_to_object(row)
    end

    def self.all
      data = Database.execute("
             SELECT * FROM #{table_name} ORDER BY created_at DESC ")

      data.map { |row| map_row_to_object(row) }
    end

    def self.where(query_matcher, value)
      data = Database.execute("SELECT * FROM #{table_name} 
              WHERE #{query_matcher} ORDER BY created_at DESC", value)

      data.map { |row| map_row_to_object(row) }
    end

    def self.last
      row = Database.execute("
            SELECT * FROM #{table_name} ORDER BY id DESC LIMIT 1").first

      map_row_to_object(row)
    end

    def self.first
      row = Database.execute("
            SELECT * FROM #{table_name} ORDER BY id LIMIT 1").first

      map_row_to_object(row)
    end

    def self.find(id)
      row = Database.execute("
            SELECT * FROM #{table_name} WHERE id = ?", id).first

      map_row_to_object(row)
    end

    def self.destroy(id)
      Database.execute("DELETE FROM #{table_name} WHERE id = ?", id)
    end

    def self.destroy_all
      Database.execute("DROP TABLE #{table_name}")
      create_table
    end
  end
end
