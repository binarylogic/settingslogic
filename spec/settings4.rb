class Settings4 < Settingslogic
  source "#{File.dirname(__FILE__)}/settings.yml", "#{File.dirname(__FILE__)}/settings_local.yml", "#{File.dirname(__FILE__)}/settings_local2.yml"
end
