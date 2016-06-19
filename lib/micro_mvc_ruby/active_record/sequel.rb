module MicroMvcRuby
  class Sequel
    def table_name
      self.class.table_name
    end

    def save
      if id
        Database.run_query("
          UPDATE #{table_name}
          SET #{update_table_placeholders} WHERE id = ?
          ", update_records)
      else
        Database.run_query("
          INSERT INTO #{table_name} (#{table_columns})
          VALUES (#{new_table_placeholders})
          ", new_record_value)
      end
    end

    alias save! save

    def update(params)
      Database.run_query("
        UPDATE #{table_name}
        SET #{update_record_placeholders(params)} WHERE id=?
        ", update_values(params))
    end

    def destroy
      Database.run_query("
        DELETE FROM #{table_name} WHERE id = ?
      ", id)
    end

    class << self
      def find_by(params)
        key = params.keys[0].to_s
        value = params.values[0].to_s
        row = Database.run_query("
              SELECT #{column_keys}
              FROM #{@table} WHERE #{key} = ?
              ", value).first
        map_row_to_object(row)
      end

      def all
        data = Database.run_query("
                SELECT #{column_keys}
                FROM #{@table} ORDER BY created_at DESC
              ")
        data.map { |row| map_row_to_object(row) }
      end

      def where(query_matcher, value)
        data = Database.run_query("
                SELECT #{column_keys} FROM
                #{@table} WHERE #{query_matcher}
                ORDER BY created_at DESC
              ", value)
        data.map { |row| map_row_to_object(row) }
      end

      def last
        row = Database.run_query("
              SELECT * FROM #{@table}
              ORDER BY id DESC LIMIT 1
              ").first
        map_row_to_object(row)
      end

      def first
        row = Database.run_query("
              SELECT * FROM #{@table}
              ORDER BY id LIMIT 1
              ").first
        map_row_to_object(row)
      end

      def find(id)
        row = Database.run_query("
              SELECT #{column_keys}
              FROM #{@table} WHERE id = ?
              ", id).first
        map_row_to_object(row)
      end

      def destroy(id)
        Database.run_query("DELETE FROM #{table_name} WHERE id = ?", id)
      end

      def destroy_all
        Database.run_query("DROP TABLE #{@table}")
        create_table
      end
    end
  end
end
