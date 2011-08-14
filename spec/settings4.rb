class Settings4 < Settingslogic
  source "#{File.dirname(__FILE__)}/settings.yml", "#{File.dirname(__FILE__)}/settings_local.yml"
end
                                                                              
class Settings4a < Settingslogic
  source "#{File.dirname(__FILE__)}/settings.yml", "#{File.dirname(__FILE__)}/settings_local_missing.yml", "#{File.dirname(__FILE__)}/settings_invalid.yml"
end

class Settings4b < Settingslogic
  source "#{File.dirname(__FILE__)}/settings_local_missing.yml"
end

class Settings4c < Settingslogic
  source "#{File.dirname(__FILE__)}/settings_invalid.yml"
end
