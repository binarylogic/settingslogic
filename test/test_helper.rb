require "test/unit"
require "rubygems"
require "ruby-debug"
require File.dirname(__FILE__) + "/../lib/settingasm"

class Test::Unit::TestCase
  def configure
    Settingasm::Config.configure do |config|
      config.class_name = "Setting" unless defined?(::Setting)
      config.settings_file = File.dirname(__FILE__) + "/application.yml"
    end
  end
  
  def setup
    configure
  end
  
  def teardown
    configure
    Settingasm::Setting.reset!
  end
end