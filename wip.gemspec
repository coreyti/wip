# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'wip/version'

Gem::Specification.new do |s|
  s.required_rubygems_version = "> 1.3.6"

  s.name        ="wip"
  s.version     = WIP::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Corey Innis"]
  s.email       = ["support+wip@coolerator.net"]
  s.homepage    = "http://github.com/coreyti/wip"
  s.summary     = "'wip': streamlined work-in-progress projects"
  s.description = "'wip' provides tools to assist with the creation/maintenance of and collaboration on software projects"

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables        = `git ls-files -- {bin}/*`.split("\n")
  s.default_executable = "wip"
  s.require_path       = "lib"

  s.add_development_dependency 'bundler', '~> 1.0.0'
end
