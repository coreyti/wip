# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'wip/version'

Gem::Specification.new do |s|
  s.name        ="wip"
  s.version     = WIP::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Corey Innis"]
  s.email       = ["support+wip@coolerator.net"]
  s.homepage    = "http://github.com/coreyti/wip"
  s.summary     = "'wip': streamlined work-in-progress projects"
  s.description = "'wip' provides tools to assist with the creation/maintenance of and collaboration on software projects"

  s.rubyforge_project = "wip"

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables        = `git ls-files -- {bin}/*`.split("\n")
  s.default_executable = "wip"
  s.require_path       = "lib"

  s.add_development_dependency 'bundler', '~> 1.0.0'

  s.post_install_message = %Q{**************************************************

  Thank you for installing #{s.summary}

**************************************************
}
end
