# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{settingslogic}
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Johnson of Binary Logic"]
  s.date = %q{2009-06-28}
  s.email = %q{bjohnson@binarylogic.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG.rdoc",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "init.rb",
     "lib/settingslogic.rb",
     "lib/settingslogic/config.rb",
     "lib/settingslogic/settings.rb",
     "rails/init.rb",
     "settingslogic.gemspec",
     "test/application.yml",
     "test/application2.yml",
     "test/application3.yml",
     "test/config_test.rb",
     "test/setting_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/binarylogic/settingslogic}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{settingslogic}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A simple and straightforward settings solution that uses an ERB enabled YAML file and a singleton design pattern.}
  s.test_files = [
    "test/config_test.rb",
     "test/setting_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
  end
end
