class Settings5 < Settingslogic
  source "#{File.dirname(__FILE__)}/settings.yml"
  suppress_errors true
  environment_vars_fallback true
end
