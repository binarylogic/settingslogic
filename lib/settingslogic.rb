require "yaml"
require "erb"
require File.dirname(__FILE__) + "/settingslogic/config"
require File.dirname(__FILE__) + "/settingslogic/settings"

# Try to load conflicting Settings classes
begin
  Settings
rescue(NameError)
end

# Since we don't have a Settings constant, lets go ahead and use it
::Settings = Settingslogic::Settings unless defined?(Settings)