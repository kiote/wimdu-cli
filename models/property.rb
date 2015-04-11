require "database"
require "active_model"

class Property
  include ActiveModel::Model
  TABLE_NAME = 'properties'

  attr_accessor :id,
                :title,
                :property_type,
                :address,
                :rate,
                :max_guests,
                :email,
                :phone

  def initialize
    @db = Database.instance.connection
  end

  def human_readable_id
    "ABC#{id}DEF#{id+1}"
  end

  # creates new record
  def create
    @db.execute("INSERT INTO #{TABLE_NAME} VALUES('', 0, '', 0, 0, '', '')")
  end
end
