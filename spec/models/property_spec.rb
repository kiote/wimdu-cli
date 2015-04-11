require "spec_helper"
require "property"
require "database"

describe "Property" do
  let(:db) { Database.instance }
  let(:property) { Property.new }

  before do
    db.setup
  end

  it "creates blank property object" do
    expect(property).to be_instance_of(Property)
  end

  describe "property id" do
    it "creates new property, if no id specified" do
      expect(property.rowid).to_not be nil
    end

    it "returns existing property" do
      property2 = Property.new(property.rowid)
      expect(property2.rowid).to eq property.rowid
    end

    it "raises ArgumentError if no such property found" do
      expect{Property.new(-1)}.to raise_error(ArgumentError)
    end
  end

  describe ".human_readable_id" do
    it "returns human readable id" do
      property.rowid = 1
      expect(property.human_readable_id).to eq 'ABC1DEF2'
    end
  end

  describe ".create" do
    it "creates new database record" do
      rows_before = db.connection.execute("SELECT * FROM properties")
      property.create
      rows_after = db.connection.execute("SELECT * FROM properties")
      expect(rows_after.count > rows_before.count).to be true
    end

    it "returns rowid" do
      expect(property.create).to_not be nil
    end
  end

  describe ".update" do
    it "sets object attributes" do
      property.update(title: 'My house')
      expect(property.title).to eq 'My house'
    end
  end

  describe ".save" do
    it "saves changes to database" do
      property.update(title: 'My house')
      property.save
      row = db.connection.execute("SELECT * FROM properties WHERE rowid = ?",
        property.rowid)
      expect(row[0][0]).to eq 'My house'
    end
  end
end
