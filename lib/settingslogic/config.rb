module Settingslogic
  # Sets configuration on Settingslogic.
  class Config
    class << self
      def configure
        yield self
      end
      
      # The name of the file that your settings will be stored for singleton access. Meaning the settings file that will be used when calling methods on the class level:
      #
      #   Settings.setting1
      #   Settings.setting2
      #   # etc...
      #
      # All that you need to do is specify the name of the file. It will automatically look in the config directory.
      #
      # * <tt>Default:</tt> :application
      # * <tt>Accepts:</tt> Symbol or String
      def settings_file
        @settings_file ||= :application
      end
      attr_writer :settings_file
    end
  end
end