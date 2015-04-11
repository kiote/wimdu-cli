# runs main process
require 'thor'

models = File.expand_path(File.join(File.dirname(__FILE__), '../models'))
lib = File.expand_path(File.join(File.dirname(__FILE__), '../lib'))
$LOAD_PATH << models << lib

require 'property'

class App < Thor
  package_name "wimdu_app"

  desc 'list', 'list all properties'
  def list
    puts 'hi!'
  end

  desc 'new', 'creates new property'
  def new
    Database.instance.setup
    Property.new
  end
end

App.start
