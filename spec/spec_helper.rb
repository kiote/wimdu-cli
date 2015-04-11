require 'aruba/api'
require 'aruba/reporting'

# ENV for test is always "test"
ENV['ENV'] = 'test'

# adding models folder to load path
path = File.expand_path(File.join(File.dirname(__FILE__), '../models'))
$LOAD_PATH << path

RSpec.configure do |config|
  config.include Aruba::Api

  config.before(:each) do
    # On startup it might take a little longer for output to
    # arrive. On a really slow machine you might need to increase this
    # value even further.
    @aruba_io_wait_seconds = 1

    restore_env
    clean_current_dir
  end
end
