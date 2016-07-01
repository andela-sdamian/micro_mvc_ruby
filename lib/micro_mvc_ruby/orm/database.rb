module MicroMvcRuby
  class Database
    attr_accessor :db

    def initialize(db_file = 'app.db')
      @db = SQLite3::Database.new File.join db_file
    end

    def self.execute(query, *args)
      new.db.execute(query, args)
    end
  end
end
