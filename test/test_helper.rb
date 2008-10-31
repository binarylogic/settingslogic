require "test/unit"
require "rubygems"
require "ruby-debug"
require File.dirname(__FILE__) + "/../lib/settingasm"

class Test::Unit::TestCase
  def configure
    Settingasm::Config.configure do |config|
      config.settings_file = File.dirname(__FILE__) + "/application.yml"
    end
  end
  
  def setup
    configure
  end
  
  def teardown
    configure
    Settingasm::Settings.reset!
  end
end