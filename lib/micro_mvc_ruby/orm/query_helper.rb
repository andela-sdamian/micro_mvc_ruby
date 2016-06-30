module MicroMvcRuby 
  module QueryHelper 
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
  end 
end 
