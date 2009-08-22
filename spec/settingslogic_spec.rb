require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Settingslogic" do
  it "should be a hash" do
    Settings.send(:instance).should be_is_a(Hash)
  end
  
  it "should access settings" do
    Settings.setting1.should == {"setting1_child" => "saweet"}
  end
  
  it "should access nested settings" do
    Settings.setting1.setting1_child.should == "saweet"
  end
  
  it "should enable erb" do
    Settings.setting3.should == 25
  end
  
  it "should namespace settings" do
    Settings2.setting1_child.should == "saweet"
  end
end