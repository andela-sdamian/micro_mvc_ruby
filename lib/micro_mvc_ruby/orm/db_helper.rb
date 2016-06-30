module MicroMvcRuby
  module DbHelper 
    def to_table(table_name)
      @table ||= table_name
    end

    def table_name
      @table
    end

    def property(column_name, attributes)
      @properties ||= {}
      @properties[column_name] = attributes

      getter_setter column_name
    end

    def create_table
      Database.execute("
        CREATE TABLE
        IF NOT EXISTS #{table_name} (#{table_properties})
        ")
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
