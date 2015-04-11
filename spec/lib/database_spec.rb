require "spec_helper"
require "database"

describe "Database" do
  let(:database) { Database.instance }

  describe "connection" do
    it "returns SQLite3 object" do
      expect(database.connection).to be_instance_of(SQLite3::Database)
    end
  end

  describe "setup" do
    before do
      database.setup
    end

    it "creates database file" do
      expect(File.exists?(Database::DB_FILENAME)).to be true
    end

    it "creates properties table with no data" do
      rows = database.connection.execute("SELECT * FROM properties")
      expect(rows).to be_instance_of(Array)
    end
  end
end
