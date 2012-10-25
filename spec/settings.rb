class Settings < Settingslogic
  source "#{File.dirname(__FILE__)}/settings.yml"

  def dynamic_flag
    if ENV['DYNAMIC_FLAG']
      ENV['DYNAMIC_FLAG']
    else
      super
    end
  end
end

class SettingsInst < Settingslogic
end