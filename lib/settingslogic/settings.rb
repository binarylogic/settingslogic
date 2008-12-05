module Settingslogic
  # = Setting
  #
  # A simple settings solution using a YAML file. See README for more information.
  class Settings
    class << self
      def name # :nodoc:
        instance._settings.key?("name") ? instance.name : super
      end
      
      # Resets the singleton instance. Useful if you are changing the configuration on the fly. If you are changing the configuration on the fly you should consider creating instances.
      def reset!
        @instance = nil
      end
      
      private
        def instance
          @instance ||= new
        end
        
        def method_missing(name, *args, &block)
          instance.send(name, *args, &block)
        end
    end
    
    attr_accessor :_settings
    
    # Initializes a new settings object. You can initialize an object in any of the following ways:
    #
    #   Settings.new(:application) # will look for config/application.yml
    #   Settings.new("application.yaml") # will look for application.yaml
    #   Settings.new("/var/configs/application.yml") # will look for /var/configs/application.yml
    #   Settings.new(:config1 => 1, :config2 => 2)
    #
    # Basically if you pass a symbol it will look for that file in the configs directory of your rails app, if you are using this in rails. If you pass a string it should be an absolute path to your settings file.
    # Then you can pass a hash, and it just allows you to access the hash via methods.
    def initialize(name_or_hash = Config.settings_file)
      case name_or_hash
      when Hash
        self._settings = name_or_hash
      when String, Symbol
        root_path = defined?(RAILS_ROOT) ? "#{RAILS_ROOT}/config/" : ""
        file_path = name_or_hash.is_a?(Symbol) ? "#{root_path}#{name_or_hash}.yml" : name_or_hash
        self._settings = YAML.load(ERB.new(File.read(file_path)).result)
        self._settings = _settings[RAILS_ENV] if defined?(RAILS_ENV)
      else
        raise ArgumentError.new("Your settings must be a hash, a symbol representing the name of the .yml file in your config directory, or a string representing the abosolute path to your settings file.")
      end
      define_settings!
    end
    
    private
      def method_missing(name, *args, &block)
        raise NoMethodError.new("no configuration was specified for #{name}")
      end
      
      def define_settings!
        return if _settings.nil?
        _settings.each do |key, value|
          case value
          when Hash
            instance_eval <<-"end_eval", __FILE__, __LINE__
              def #{key}
                @#{key} ||= self.class.new(_settings["#{key}"])
              end
            end_eval
          else
            instance_eval <<-"end_eval", __FILE__, __LINE__
              def #{key}
                @#{key} ||= _settings["#{key}"]
              end
            end_eval
          end
        end
      end
  end
end