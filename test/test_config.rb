require File.dirname(__FILE__) + '/test_helper.rb'

class TestConfig < Test::Unit::TestCase
  def test_class_name
    Settingasm::Config.configure do |config|
      config.class_name = "Conf"
    end
    
    assert_equal Conf, Conf.setting1.class
    assert_equal "saweet", Conf.setting1.setting1_child
    assert_equal 5, Conf.setting2
    assert_equal 25, Conf.setting3
  end
  
  def test_settings_file
    Settingasm::Config.configure do |config|
      config.settings_file = File.dirname(__FILE__) + '/application2.yml'
    end
    
    Setting.reset!
    assert_equal "BenJohnson", Setting.neat.cool.awesome
    assert_equal 5, Setting.silly
    assert_equal 25, Setting.fun
  end
end