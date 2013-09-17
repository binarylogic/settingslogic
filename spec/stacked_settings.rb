class StackedSettings < Settingslogic
  namespace 'setting1'
  # source "#{File.dirname(__FILE__)}/settings.yml"
  source ["#{File.dirname(__FILE__)}/settings.yml",
      # "#{File.dirname(__FILE__)}/settings_empty.yml",
      "#{File.dirname(__FILE__)}/settings2.yml"]
  load!
end