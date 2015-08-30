class Settings < Settingslogic
  source ["#{File.dirname(__FILE__)}/settings.yml","#{File.dirname(__FILE__)}/settings2.yml"]
end

class SettingsInst < Settingslogic
end