require "spec_helper"
require "property"
require "database"

describe "Property" do
  let(:property) { Property.new }

  it "creates blank property object" do
    expect(property).to be_instance_of(Property)
  end

  describe ".human_readable_id" do
    it "returns human readable id" do
      property.id = 1
      expect(property.human_readable_id).to eq 'ABC1DEF2'
    end
  end

  describe "create" do
    let(:db) { Database.instance }

    before do
      db.setup
    end

    it "creates new database record" do
      rows_before = db.connection.execute("SELECT * FROM properties")
      property.create
      rows_after = db.connection.execute("SELECT * FROM properties")
      expect(rows_after.count - rows_before.count).to eq 1
    end
  end
end
