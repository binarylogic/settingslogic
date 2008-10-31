require File.dirname(__FILE__) + '/test_helper.rb'

class TestSetting < Test::Unit::TestCase
  def test_singleton_access
    assert_equal Setting, Setting.setting1.class
    assert_equal "saweet", Setting.setting1.setting1_child
    assert_equal 5, Setting.setting2
    assert_equal 25, Setting.setting3
  end
  
  def test_instances
    settings1 = Setting.new(File.dirname(__FILE__) + '/application.yml')
    assert_equal "saweet", settings1.setting1.setting1_child
    assert_equal 5, settings1.setting2
    assert_equal 25, settings1.setting3
    
    settings2 = Setting.new(File.dirname(__FILE__) + '/application2.yml')
    assert_equal "BenJohnson", settings2.neat.cool.awesome
    assert_equal 5, settings2.silly
    assert_equal 25, settings2.fun
  end
  
  def test_method_missing
    assert_raise(NoMethodError) { Setting.doesnt_exist }
    settings1 = Setting.new(File.dirname(__FILE__) + '/application.yml')
    assert_raise(NoMethodError) { settings1.doesnt_exist }
  end
end