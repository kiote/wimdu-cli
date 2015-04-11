require "database"
require "active_model"

class Property
  include ActiveModel::Model
  TABLE_NAME = 'properties'

  attr_accessor :rowid,
                :title,
                :property_type,
                :address,
                :rate,
                :max_guests,
                :email,
                :phone

  def initialize(property_id = 0)
    @db = Database.instance.connection
    if property_id == 0
      create
    else
      self.rowid = property_id
      row = @db.execute("SELECT * FROM #{TABLE_NAME} WHERE rowid = ?", property_id)
      raise ArgumentError, 'no such property id' unless row.count > 0
      values = row.first
      # bit rude methot to digg into db results...
      self.title = values[0]
      self.property_type = values[1]
      self.address = values[2]
      self.rate = values[3]
      self.max_guests = values[4]
      self.email = values[5]
      self.phone = values[6]
    end
  end

  def human_readable_id
    "ABC#{rowid}DEF#{rowid+1}"
  end

  # creates new record
  def create
    @db.execute("INSERT INTO #{TABLE_NAME} VALUES('', 0, '', 0, 0, '', '')")
    self.rowid = @db.last_insert_row_id
  end

  def save
    @db.execute("UPDATE #{TABLE_NAME} SET title = ?, property_type = ?,
      address = ?, rate = ?, max_guests = ?, email = ?, phone = ?",
      self.title, self.property_type, self.address, self.rate,
      self.max_guests, self.email, self.phone)
  end

  def self.list
    @db = Database.instance.connection
    rows = @db.execute("SELECT * FROM #{TABLE_NAME}")
  end
end
