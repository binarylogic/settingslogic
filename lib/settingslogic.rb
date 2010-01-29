require "yaml"
require "erb"

# A simple settings solution using a YAML file. See README for more information.
class Settingslogic < Hash
  class MissingSetting < StandardError; end
  
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
    
    def [](key)
      # Setting.key.value or Setting[:key][:value] or Setting['key']['value']
      fetch(key.to_s,nil)
    end

    def []=(key,val)
      # Setting[:key] = 'value' for dynamic settings
      store(key.to_s,val)
    end
    
    def load!
      instance
      true
    end
    
    def reload!
      @instance = nil
      load!
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
  # Basically if you pass a symbol it will look for that file in the configs directory of your rails app,
  # if you are using this in rails. If you pass a string it should be an absolute path to your settings file.
  # Then you can pass a hash, and it just allows you to access the hash via methods.
  def initialize(hash_or_file = self.class.source, section = nil)
    case hash_or_file
    when Hash
      self.replace hash_or_file
    else
      hash = YAML.load(ERB.new(File.read(hash_or_file)).result).to_hash
      hash = hash[self.class.namespace] if self.class.namespace
      self.replace hash
    end
    @section = section || hash_or_file  # so end of error says "in application.yml"
    create_accessors!
  end

  # Called for dynamically-defined keys, and also the first key deferenced at the top-level, if load! is not used.
  # Otherwise, create_accessors! (called by new) will have created actual methods for each key.
  def method_missing(key, *args, &block)
    begin
      value = fetch(key.to_s)
    rescue IndexError
      raise MissingSetting, "Missing setting '#{key}' in #{@section}"
    end
    value.is_a?(Hash) ? self.class.new(value, "'#{key}' section in #{@section}") : value
  end

  private
    # This handles naming collisions with Sinatra/Vlad/Capistrano. Since these use a set()
    # helper that defines methods in Object, ANY method_missing ANYWHERE picks up the Vlad/Sinatra
    # settings!  So settings.deploy_to title actually calls Object.deploy_to (from set :deploy_to, "host"),
    # rather than the app_yml['deploy_to'] hash.  Jeezus.
    def create_accessors!
      self.each do |key,val|
        # Use instance_eval/class_eval because they're actually more efficient than define_method{}
        # http://stackoverflow.com/questions/185947/ruby-definemethod-vs-def
        # http://bmorearty.wordpress.com/2009/01/09/fun-with-rubys-instance_eval-and-class_eval/
        self.class.class_eval <<-EndEval
          def #{key}
            return @#{key} if @#{key}  # cache (performance)
            value = fetch('#{key}')
            @#{key} = value.is_a?(Hash) ? self.class.new(value, "'#{key}' section in #{@section}") : value
          end
        EndEval
      end
    end

end
