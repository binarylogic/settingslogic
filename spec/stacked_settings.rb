class StackedSettings < Settingslogic
  source ["#{File.dirname(__FILE__)}/settings.yml",
      "#{File.dirname(__FILE__)}/settings_empty.yml",
      "#{File.dirname(__FILE__)}/settings2.yml",
      {"setting2" => 10}]
  load!
end