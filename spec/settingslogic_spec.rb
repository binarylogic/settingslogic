require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Settingslogic" do
  it "should access settings" do
    expect(Settings.setting2).to eq(5)
  end
  
  it "should access nested settings" do
    expect(Settings.setting1.setting1_child).to eq("saweet")
  end
  
  it "should access settings in nested arrays" do
    expect(Settings.array.first.name).to eq("first")
  end

  it "should access deep nested settings" do
    expect(Settings.setting1.deep.another).to eq("my value")
  end

  it "should access extra deep nested settings" do
    expect(Settings.setting1.deep.child.value).to eq(2)
  end

  it "should enable erb" do
    expect(Settings.setting3).to eq(25)
  end

  it "should namespace settings" do
    expect(Settings2.setting1_child).to eq("saweet")
    expect(Settings2.deep.another).to eq("my value")
  end

  it "should return the namespace" do
    expect(Settings.namespace).to be_nil
    expect(Settings2.namespace).to eq('setting1')
  end

  it "should distinguish nested keys" do
    expect(Settings.language.haskell.paradigm).to eq('functional')
    expect(Settings.language.smalltalk.paradigm).to eq('object oriented')
  end
  
  it "should not collide with global methods" do
    expect(Settings3.nested.collides.does).to eq('not either')
    Settings3[:nested] = 'fooey'
    expect(Settings3[:nested]).to eq('fooey')
    expect(Settings3.nested).to eq('fooey')
    expect(Settings3.collides.does).to eq('not')
  end

  it "should raise a helpful error message" do
    e = nil
    begin
      Settings.missing
    rescue => e
      expect(e).to be_kind_of Settingslogic::MissingSetting
    end
    expect(e).not_to be_nil
    expect(e.message).to match(/Missing setting 'missing' in/)

    e = nil
    begin
      Settings.language.missing
    rescue => e
      expect(e).to be_kind_of Settingslogic::MissingSetting
    end
    expect(e).not_to be_nil
    expect(e.message).to match(/Missing setting 'missing' in 'language' section/)
  end

  it "should handle optional / dynamic settings" do
    e = nil
    begin
      Settings.language.erlang
    rescue => e
      expect(e).to be_kind_of Settingslogic::MissingSetting
    end
    expect(e).not_to be_nil
    expect(e.message).to match(/Missing setting 'erlang' in 'language' section/)
    
    expect(Settings.language['erlang']).to be_nil
    Settings.language['erlang'] = 5
    expect(Settings.language['erlang']).to eq(5)

    Settings.language['erlang'] = {'paradigm' => 'functional'}
    expect(Settings.language.erlang.paradigm).to eq('functional')
    expect(Settings.respond_to?('erlang')).to be_falsey

    Settings.reload!
    expect(Settings.language['erlang']).to be_nil

    Settings.language[:erlang] ||= 5
    expect(Settings.language[:erlang]).to eq(5)

    Settings.language[:erlang] = {}
    Settings.language[:erlang][:paradigm] = 'functional'
    expect(Settings.language.erlang.paradigm).to eq('functional')

    Settings[:toplevel] = '42'
    expect(Settings.toplevel).to eq('42')
  end

  it "should raise an error on a nil source argument" do
    class NoSource < Settingslogic; end
    e = nil
    begin
      NoSource.foo.bar
    rescue => e
      expect(e).to be_kind_of Errno::ENOENT
    end
    expect(e).not_to be_nil
  end

  it "should allow suppressing errors" do
    expect(Settings4.non_existent_key).to be_nil
  end

  # This one edge case currently does not pass, because it requires very
  # esoteric code in order to make it pass.  It was judged not worth fixing,
  # as it introduces significant complexity for minor gain.
  # it "should handle reloading top-level settings"
  #   Settings[:inspect] = 'yeah baby'
  #   Settings.inspect.should == 'yeah baby'
  #   Settings.reload!
  #   Settings.inspect.should == 'Settings'
  # end

  it "should handle oddly-named settings" do
    Settings.language['some-dash-setting#'] = 'dashtastic'
    expect(Settings.language['some-dash-setting#']).to eq('dashtastic')
  end

  it "should handle settings with nil value" do
    Settings["flag"] = true
    Settings["flag"] = nil
    expect(Settings.flag).to eq(nil)
  end

  it "should handle settings with false value" do
    Settings["flag"] = true
    Settings["flag"] = false
    expect(Settings.flag).to eq(false)
  end

  it "should support instance usage as well" do
    settings = SettingsInst.new(Settings.source)
    expect(settings.setting1.setting1_child).to eq("saweet")
  end

  it "should be able to get() a key with dot.notation" do
    expect(Settings.get('setting1.setting1_child')).to eq("saweet")
    expect(Settings.get('setting1.deep.another')).to eq("my value")
    expect(Settings.get('setting1.deep.child.value')).to eq(2)
  end

  # If .name is not a property, delegate to superclass
  it "should respond with Module.name" do
    expect(Settings2.name).to eq("Settings2")
  end

  # If .name is called on Settingslogic itself, handle appropriately
  # by delegating to Hash
  it "should have the parent class always respond with Module.name" do
    expect(Settingslogic.name).to eq('Settingslogic')
  end

  # If .name is a property, respond with that instead of delegating to superclass
  it "should allow a name setting to be overriden" do
    expect(Settings.name).to eq('test')
  end
  
  it "should allow symbolize_keys" do
    Settings.reload!
    result = Settings.language.haskell.symbolize_keys 
    expect(result.class).to eq(Hash)
    expect(result).to eq({:paradigm => "functional"}) 
  end
  
  it "should allow symbolize_keys on nested hashes" do
    Settings.reload!
    result = Settings.language.symbolize_keys
    expect(result.class).to eq(Hash)
    expect(result).to eq({
      :haskell => {:paradigm => "functional"},
      :smalltalk => {:paradigm => "object oriented"}
    })
  end

  it "should handle empty file" do
    expect(SettingsEmpty.keys).to eql([])
  end

  # Put this test last or else call to .instance will load @instance,
  # masking bugs.
  it "should be a hash" do
    expect(Settings.send(:instance)).to be_is_a(Hash)
  end

  describe "#to_hash" do
    it "should return a new instance of a Hash object" do
      expect(Settings.to_hash).to be_kind_of(Hash)
      expect(Settings.to_hash.class.name).to eq("Hash")
      expect(Settings.to_hash.object_id).not_to eq(Settings.object_id)
    end
  end

end
