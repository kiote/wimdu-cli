# runs main process

models = File.expand_path(File.join(File.dirname(__FILE__), '../models'))
lib = File.expand_path(File.join(File.dirname(__FILE__), '../lib'))
$LOAD_PATH << models << lib

require "thor"
require "property"
require "highline/import"

class App < Thor
  package_name "wimdu_app"

  desc 'list', 'list all properties'
  def list
    rows = Property.list
    if rows.count == 0
      say "No properties found."
    else
      say "Found #{rows.count} offer(s)"
      # puts rows.inspect
      # rows.each do |row|
      #   say "#{row['rowid']}: #{row['title']} "
      # end
    end
  end

  desc 'new', 'creates new property'
  def new
    Database.instance.setup
    property = Property.new

    say "Starting with new property #{property.human_readable_id}"

    property.title = ask("Title: ")
    property.save

    say("Property types:\n0 – holiday home\n1 – apartment\n2 – private room")
    property.property_type = ask("Property type: ") { |q| q.in = 0..2 }
    property.save

    property.address = ask("Address: ")
    property.save

    property.rate = ask("Nightly rate (EUR): ", Integer) { |q| q.validate = /\A[^0-9.]\Z/}
    property.save
  end
end

App.start
