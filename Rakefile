ENV['RDOCOPT'] = "-S -f html -T hanna"

require "rubygems"
require "hoe"
require File.dirname(__FILE__) << "/lib/settingslogic/version"

Hoe.new("Settingslogic", Settingslogic::Version::STRING) do |p|
  p.name = "settingslogic"
  p.author = "Ben Johnson of Binary Logic"
  p.email  = 'bjohnson@binarylogic.com'
  p.summary = "A simple and straightforward settings solution that uses an ERB enabled YAML file and a singleton design pattern."
  p.description = "A simple and straightforward settings solution that uses an ERB enabled YAML file and a singleton design pattern."
  p.url = "http://github.com/binarylogic/settingslogic"
  p.history_file = "CHANGELOG.rdoc"
  p.readme_file = "README.rdoc"
  p.extra_rdoc_files = ["CHANGELOG.rdoc", "README.rdoc"]
  p.remote_rdoc_dir = ''
  p.test_globs = ["test/*/test_*.rb", "test/*_test.rb", "test/*/*_test.rb"]
  p.extra_deps = %w(activesupport)
end