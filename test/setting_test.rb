require File.dirname(__FILE__) + '/test_helper.rb'

class TestSetting < Test::Unit::TestCase
  def test_conflicting_class_methods
    assert_equal "test", Settings.name
  end
  
  def test_singleton_access
    assert_equal Settings, Settings.setting1.class
    assert_equal "saweet", Settings.setting1.setting1_child
    assert_equal 5, Settings.setting2
    assert_equal 25, Settings.setting3
  end
  
  def test_instances
    settings1 = Settings.new(File.dirname(__FILE__) + '/application.yml')
    assert_equal "saweet", settings1.setting1.setting1_child
    assert_equal 5, settings1.setting2
    assert_equal 25, settings1.setting3
    
    settings2 = Settings.new(File.dirname(__FILE__) + '/application2.yml')
    assert_equal "BenJohnson", settings2.neat.cool.awesome
    assert_equal 5, settings2.silly
    assert_equal 25, settings2.fun
  end
  
  def test_method_missing
    assert_raise(NoMethodError) { Settings.doesnt_exist }
    settings1 = Settings.new(File.dirname(__FILE__) + '/application.yml')
    assert_raise(NoMethodError) { settings1.doesnt_exist }
  end
  
  def test_initialized_with_hash
    settings1 = Settings.new(
        :silly => 5,
        'fun' => 25,
        :neat => { 'cool' => { :awesome => "BenJohnson" } }
      )
    assert_equal "BenJohnson", settings1.neat.cool.awesome
    assert_equal 5, settings1.silly
    assert_equal 25, settings1.fun
  end
  
  def test_environment_specific_settings
    in_test_environment do
      settings1 = Settings.new(File.dirname(__FILE__) + '/application3.yml')
      assert_equal 25, settings1.fun
      assert_equal "test_specific", settings1.silly
    end
  end
  
  def test_environment_specific_settings_when_initialized_with_hash
    in_test_environment do
      settings1 = Settings.new(
          :silly => 5,
          'fun' => 25,
          :test => { :silly => "test_specific" }
        )
      assert_equal 25, settings1.fun
      assert_equal "test_specific", settings1.silly
    end
  end
end