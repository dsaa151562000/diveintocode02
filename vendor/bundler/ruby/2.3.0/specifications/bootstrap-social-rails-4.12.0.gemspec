# -*- encoding: utf-8 -*-
# stub: bootstrap-social-rails 4.12.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bootstrap-social-rails"
  s.version = "4.12.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Gavin Lam"]
  s.date = "2016-03-27"
  s.description = "bootstrap-social for Rails asset pipeline"
  s.email = ["me@gavin.hk"]
  s.homepage = "https://github.com/gavinkflam/bootstrap-social-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "bootstrap-social for Rails asset pipeline"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
  end
end
