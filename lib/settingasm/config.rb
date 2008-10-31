module Settingasm
  # = Config
  # Sets configuration on Settingasm.
  class Config
    class << self
      def configure
        yield self
      end
    
      # The name of the class you want to use to access your settings. Maybe you don't like "Setting" or maybe it will conflict with a model you have. Just set this to "AppSetting" or "Config", whatever you want.
      #
      # * <tt>Default:</tt> "Setting"
      # * <tt>Accepts:</tt> Symbol or String
      def class_name
        @class_name
      end
      
      def class_name=(value) # :nodoc:
        eval("::#{value} = Setting")
        @class_name = value
      end
    
      # The name of the file that your settings will be stored for singleton access. Meaning the settings file that will be used when calling methods on the class level:
      #
      #   Setting.setting1
      #   Setting.setting2
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