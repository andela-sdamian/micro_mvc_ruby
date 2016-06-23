require 'sqlite3'
require_relative 'sequel'

module MicroMvcRuby
  class BaseRecord < Sequel
    def table_columns
      self.class.column_keys.gsub('id, ', '')
    end

    def record_values
      properties = self.class.column_keys.split(',')
      properties.delete(:id)
      properties.map { |method| send(method) }
    end

    alias new_record_value record_values

    def update_records
      record_values << send(:id)
    end

    def update_values(params)
      params.values << id
    end

    def new_table_placeholders
      properties = self.class.column_keys.split(',')
      (['?'] * properties.size).join(',')
    end

    def update_record_placeholders(params)
      placeholders = params.keys
      placeholders.delete(:id)
      placeholders.map { |col| "#{col}=?" }.join(',')
    end

    def update_table_placeholders
      placeholders = self.class.column_keys.split(',')
      placeholders.delete(:id)
      placeholders.map { |col| "#{col}=?" }.join(',')
    end

    class << self
      def to_table(table_name)
        @table = table_name
      end

      def table_name
        @table
      end

      def property(column_name, attributes)
        @properties ||= {}
        @properties[column_name] = attributes
      end

      def create_table
        Database.run_query("
          CREATE TABLE
          IF NOT EXISTS #{@table} (#{table_properties})
          ")
        make_methods
      end

      def table_properties
        all_properties = []
        @properties.each do |key, value|
          properties ||= []
          properties << key.to_s
          value.each do |name, type|
            properties << send("#{name.downcase}_constraint", type)
          end
          all_properties << properties.join(' ')
        end
        
        all_properties.join(', ')
      end

      def make_methods
        @properties.keys.map(&:to_sym).each do |method|
          attr_accessor method
        end
      end

      def primary_key_constraint(value = false)
        'PRIMARY KEY AUTOINCREMENT' if value
      end

      def nullable_constraint(value = true)
        'NOT NULL' unless value
      end

      def type_constraint(value)
        value.to_s
      end

      def column_keys
        @properties.keys.join(',')
      end

      def map_row_to_object(row)
        model = new 
        @properties.each_key.with_index do |value, index|
          model.send("#{value}=", row[index])
        end

        model
      end
    end
  end
end
