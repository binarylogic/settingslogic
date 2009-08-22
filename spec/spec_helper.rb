require 'spec'
require 'rubygems'
require 'ruby-debug'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'settingslogic'
require 'settings'
require 'settings2'

Spec::Runner.configure do |config|
end
