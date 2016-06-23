# -*- encoding: utf-8 -*-
# stub: jc-validates_timeliness 3.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jc-validates_timeliness"
  s.version = "3.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Adam Meehan", "John Carney"]
  s.date = "2014-07-17"
  s.description = "Adds validation methods to ActiveModel for validating dates and times. Works with multiple ORMS."
  s.email = "adam.meehan@gmail.com"
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "LICENSE"]
  s.files = ["CHANGELOG.rdoc", "LICENSE"]
  s.homepage = "http://github.com/johncarney/validates_timeliness"
  s.rubygems_version = "2.5.1"
  s.summary = "Date and time validation plugin for Rails which allows custom formats"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<timeliness>, ["~> 0.3.7"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec-collection_matchers>, [">= 0"])
    else
      s.add_dependency(%q<timeliness>, ["~> 0.3.7"])
      s.add_dependency(%q<coveralls>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<rspec-rails>, ["~> 3.0"])
      s.add_dependency(%q<rspec-collection_matchers>, [">= 0"])
    end
  else
    s.add_dependency(%q<timeliness>, ["~> 0.3.7"])
    s.add_dependency(%q<coveralls>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<rspec-rails>, ["~> 3.0"])
    s.add_dependency(%q<rspec-collection_matchers>, [">= 0"])
  end
end
