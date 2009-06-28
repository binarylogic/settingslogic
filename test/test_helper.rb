require "test/unit"
require "rubygems"
require "ruby-debug"
require File.dirname(__FILE__) + "/../lib/settingslogic"

class Test::Unit::TestCase
  def configure
    Settingslogic::Config.configure do |config|
      config.settings_file = File.dirname(__FILE__) + "/application.yml"
    end
  end
  
  def setup
    configure
  end
  
  def teardown
    configure
    Settingslogic::Settings.reset!
  end
  
  def in_test_environment(&block)
    Settingslogic::Settings.const_set :RAILS_ENV, "test"
    block.call
    Settingslogic::Settings.send :remove_const, :RAILS_ENV
  end
end