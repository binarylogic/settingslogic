require "yaml"
require "erb"
require File.dirname(__FILE__) + "/settingasm/config"
require File.dirname(__FILE__) + "/settingasm/settings"

# Try to load conflicting Settings classes
begin
  Settings
rescue(NameError)
end

# Since we don't have a Settings constant, lets go ahead and use it
::Settings = Settingasm::Settings unless defined?(Settings)