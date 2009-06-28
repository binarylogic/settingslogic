module Settingslogic
  # A simple settings solution using a YAML file. See README for more information.
  class Settings < Hash
    class << self
      def name # :nodoc:
        instance.key?("name") ? instance.name : super
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
        self.update name_or_hash
      when String, Symbol
        root_path = defined?(RAILS_ROOT) ? "#{RAILS_ROOT}/config/" : ""
        file_path = name_or_hash.is_a?(Symbol) ? "#{root_path}#{name_or_hash}.yml" : name_or_hash
        self.update YAML.load(ERB.new(File.read(file_path)).result).to_hash
      else
        raise ArgumentError.new("Your settings must be a hash, a symbol representing the name of the .yml file in your config directory, or a string representing the abosolute path to your settings file.")
      end
      if defined?(RAILS_ENV)
        rails_env = self.keys.include?(RAILS_ENV) ? RAILS_ENV : RAILS_ENV.to_sym
        self.update self[rails_env] if self[rails_env]
      end
      define_settings!
    end
    
    private
      def method_missing(name, *args, &block)
        raise NoMethodError.new("no configuration was specified for #{name}")
      end
      
      def define_settings!
        self.each do |key, value|
          case value
          when Hash
            instance_eval <<-"end_eval", __FILE__, __LINE__
              def #{key}
                @#{key} ||= self.class.new(self[#{key.inspect}])
              end
            end_eval
          else
            instance_eval <<-"end_eval", __FILE__, __LINE__
              def #{key}
                @#{key} ||= self[#{key.inspect}]
              end
              def #{key}=(value)
                @#{key} = value
              end
            end_eval
          end
        end
      end
  end
end