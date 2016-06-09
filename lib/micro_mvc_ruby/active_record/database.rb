module MicroMvcRuby
  class Database
    class << self
      attr_accessor :db

      def connect
        @db = SQLite3::Database.new File.join 'app.db'
      end

      def run_query(query, *args)
        @db ||= connect
        @db.execute(query, args)
      end
    end
  end
end
