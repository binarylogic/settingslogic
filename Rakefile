require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "settingslogic"
    gem.summary = "A simple and straightforward settings solution that uses an ERB enabled YAML file and a singleton design pattern."
    gem.email = "bjohnson@binarylogic.com"
    gem.homepage = "http://github.com/binarylogic/settingslogic"
    gem.authors = ["Ben Johnson of Binary Logic"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec
