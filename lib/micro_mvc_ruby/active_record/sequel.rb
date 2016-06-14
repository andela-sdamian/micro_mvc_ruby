module MicroMvcRuby
  class Sequel

    def table_name 
      self.class.table_name
    end 

    def save
      if id
        Database.run_query(<<SQL, update_records)
UPDATE #{table_name}
SET #{update_table_placeholders} WHERE id = ?
SQL
      else
        Database.run_query(<<SQL, new_record_value)
INSERT INTO #{table_name} (#{table_columns})
VALUES (#{new_table_placeholders})
SQL
      end
    end

    alias save! save
    def update(params)
      Database.run_query(<<SQL, update_values(params))
UPDATE #{table_name}
SET #{update_record_placeholders(params)} WHERE id=?
SQL
    end

    def destroy
      Database.run_query(<<SQL, id)
DELETE FROM #{table_name} WHERE id = ?
SQL
    end

    class << self
      def find_by(params)
        key = params.keys[0].to_s
        value = params.values[0].to_s
        row = Database.run_query(<<SQL, value).first
SELECT #{column_keys}
FROM #{@table} WHERE #{key} = ?
SQL
        map_row_to_object(row)
      end

      def all
        data = Database.run_query(<<SQL)
SELECT #{column_keys}
FROM #{@table} ORDER BY created_at DESC
SQL
        data.map { |row| map_row_to_object(row) }
      end

      def where(query_matcher, value)
        data = Database.run_query(<<SQL, value)
SELECT #{column_keys} FROM
#{@table} WHERE #{query_matcher}
ORDER BY created_at DESC
SQL
        data.map { |row| map_row_to_object(row) }
      end

      def last
        row = Database.run_query(<<SQL).first
SELECT * FROM #{@table}
ORDER BY id DESC LIMIT 1
SQL
        map_row_to_object(row)
      end

      def first
        row = Database.run_query(<<SQL).first
SELECT * FROM #{@table}
ORDER BY id LIMIT 1
SQL
        map_row_to_object(row)
      end

      def find(id)
        row = Database.run_query(<<SQL, id).first
SELECT #{column_keys}
FROM #{@table} WHERE id = ?
SQL
        map_row_to_object(row)
      end

      def destroy_all
        Database.run_query(<<SQL)
DROP TABLE #{@table}
SQL
      create_table
      end
    end
  end
end
