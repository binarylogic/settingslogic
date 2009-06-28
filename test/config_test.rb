require File.dirname(__FILE__) + '/test_helper.rb'

class TestConfig < Test::Unit::TestCase
  def test_settings_file
    Settingslogic::Config.configure do |config|
      config.settings_file = File.dirname(__FILE__) + '/application2.yml'
    end
    
    Settings.reset!
    assert_equal "BenJohnson", Settings.neat.cool.awesome
    assert_equal 5, Settings.silly
    assert_equal 25, Settings.fun
  end
end