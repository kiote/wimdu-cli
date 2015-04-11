# runs main process
require "sqlite3"
DB_FILENAME = 'db/wimdu_property_test.db'
File.delete(DB_FILENAME) if File.exists?(DB_FILENAME)
db = SQLite3::Database.new(DB_FILENAME)
db.execute("CREATE TABLE properties(title TEXT, property_type TINYINT,
  address TEXT, rate INT, max_guests TINYINT, email VARCHAR(255), phone VARCHAR(255))")
db.execute("INSERT INTO properties VALUES('',0,'',0,0,'','')")
