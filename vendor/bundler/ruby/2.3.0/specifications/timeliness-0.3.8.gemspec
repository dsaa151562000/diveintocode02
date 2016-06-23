# -*- encoding: utf-8 -*-
# stub: timeliness 0.3.8 ruby lib

Gem::Specification.new do |s|
  s.name = "timeliness"
  s.version = "0.3.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Adam Meehan"]
  s.date = "2016-01-06"
  s.description = "Fast date/time parser with customisable formats, timezone and I18n support."
  s.email = "adam.meehan@gmail.com"
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG.rdoc"]
  s.files = ["CHANGELOG.rdoc", "README.rdoc"]
  s.homepage = "http://github.com/adzap/timeliness"
  s.rubyforge_project = "timeliness"
  s.rubygems_version = "2.5.1"
  s.summary = "Date/time parsing for the control freak."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<activesupport>, [">= 3.2"])
      s.add_development_dependency(%q<tzinfo>, [">= 0.3.31"])
      s.add_development_dependency(%q<rspec>, ["~> 3.4"])
      s.add_development_dependency(%q<timecop>, [">= 0"])
      s.add_development_dependency(%q<i18n>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 3.2"])
      s.add_dependency(%q<tzinfo>, [">= 0.3.31"])
      s.add_dependency(%q<rspec>, ["~> 3.4"])
      s.add_dependency(%q<timecop>, [">= 0"])
      s.add_dependency(%q<i18n>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3.2"])
    s.add_dependency(%q<tzinfo>, [">= 0.3.31"])
    s.add_dependency(%q<rspec>, ["~> 3.4"])
    s.add_dependency(%q<timecop>, [">= 0"])
    s.add_dependency(%q<i18n>, [">= 0"])
  end
end
