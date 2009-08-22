require "yaml"
require "erb"

# A simple settings solution using a YAML file. See README for more information.
class Settingslogic < Hash
  class UndefinedSetting < StandardError; end
  
  class << self
    def name # :nodoc:
      instance.key?("name") ? instance.name : super
    end
    
    def source(value = nil)
      if value.nil?
        @source
      else
        @source = value
      end
    end
    
    def namespace(value = nil)
      if value.nil?
        @namespace
      else
        @namespace = value
      end
    end
    
    private
      def instance
        @instance ||= new
      end
      
      def method_missing(name, *args, &block)
        instance.send(name, *args, &block)
      end
  end
  
  # Initializes a new settings object. You can initialize an object in any of the following ways:
  #
  #   Settings.new(:application) # will look for config/application.yml
  #   Settings.new("application.yaml") # will look for application.yaml
  #   Settings.new("/var/configs/application.yml") # will look for /var/configs/application.yml
  #   Settings.new(:config1 => 1, :config2 => 2)
  #
  # Basically if you pass a symbol it will look for that file in the configs directory of your rails app, if you are using this in rails. If you pass a string it should be an absolute path to your settings file.
  # Then you can pass a hash, and it just allows you to access the hash via methods.
  def initialize(hash_or_file = self.class.source)
    case hash_or_file
    when Hash
      self.update hash_or_file
    else
      hash = YAML.load(ERB.new(File.read(hash_or_file)).result).to_hash
      hash = hash[self.class.namespace] if self.class.namespace
      self.update hash
    end
    
    define_settings!
  end
  
  private
    def method_missing(name, *args, &block)
      raise UndefinedSetting.new("The '#{name}' was not found in your configuration file: #{self.class.source}")
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