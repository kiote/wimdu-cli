# stores all information about database connection
# gives the connection itself
require "sqlite3"
require "env"
require "singleton"

class Database
  include Singleton # as we don't need more than one of this
  include Env

  DB_FILENAME = test? ? 'db/wimdu_property_test.db' : 'db/wimdu_property.db'

  def connection
    @db ||= SQLite3::Database.new(DB_FILENAME)
  end

  # create necessary tables
  def setup
    connection

    @db.execute("CREATE TABLE IF NOT EXISTS properties(title TEXT, property_type TINYINT,
      address TEXT, rate INT, max_guests TINYINT, email VARCHAR(255), phone VARCHAR(255))")
  end
end
