require "test/unit"
require "rubygems"
require "ruby-debug"
require File.dirname(__FILE__) + "/../lib/settingslogic"

class Test::Unit::TestCase
  def configure
    Settinglogic::Config.configure do |config|
      config.settings_file = File.dirname(__FILE__) + "/application.yml"
    end
  end
  
  def setup
    configure
  end
  
  def teardown
    configure
    Settinglogic::Settings.reset!
  end
end