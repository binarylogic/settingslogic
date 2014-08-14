class Settings < Settingslogic
  source "#{File.dirname(__FILE__)}/settings.yml"
end

class SettingsInst < Settingslogic
end

class SettingsNestedNamespace < Settingslogic
  source "#{File.dirname(__FILE__)}/settings.yml"
  namespace "language.smalltalk"
end

class SettingsInvalidNestedNamespace < Settingslogic
  source "#{File.dirname(__FILE__)}/settings.yml"
  namespace "inexistent.namespace.omg"
end
