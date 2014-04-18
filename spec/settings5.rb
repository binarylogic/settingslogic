class Settings5 < Settingslogic
  source "#{File.dirname(__FILE__)}/settings.yml"
  after_load {
    setting1['setting1_child'] = 'supa saweet'
  }
end