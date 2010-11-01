# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "wip/version"

BOOTSTRAP_VERSION = "1.0"

begin
  require "rubygems"
  gem     "wip-bootstrap", "= #{BOOTSTRAP_VERSION}"
  require "wip-bootstrap"
rescue LoadError => e
  puts %{
WARNING:
#{e.message}wip-bootstrap must be pre-installed. I'll try to grab that now.

}
  local = File.join(File.dirname(__FILE__), '..', 'wip-bootstrap')

  if File.exist?(local)
    `cd #{local} && rake install`
  else
    `gem install wip-bootstrap`
  end
end

Gem.clear_paths
gem     "wip-bootstrap", "= #{BOOTSTRAP_VERSION}"
require "wip-bootstrap"
WIP::Bootstrap.run

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
  s.executables        = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.default_executable = "wip"
  s.require_path       = "lib"

  s.add_runtime_dependency     'wip-bootstrap', BOOTSTRAP_VERSION
  s.add_development_dependency 'bundler',       '~> 1.0.0'

  s.post_install_message = %Q{
Thank you for installing #{s.name} v#{s.version}
------------------------------------------------------------------------------

What happened:

  * First, `wip` depends on `wip-bootstrap`, which should have been installed
    for you if it wasn't already around. `wip-bootstrap` simply adds a few
    bash wrappers to `wip` and sets up your bash profile.

    `wip-bootstrap` shouldn't have to be updated too often, and updates to
    `wip` will not attempt to re-bootstrap, unless dependent on a new
    bootstrap version.

    If bootstrapping *was* run, you should have seen a related banner
    preceding this one.
  * `wip` provides ruby CLI utilities that are meant to assist with software
    project workspace and workflow management (called 'works').

    The executable doing most of the heavy lifting is:

        wip-ruby

  * However, one of the things `wip-bootstrap` takes care of is add a bash
    function called `wip` to your environment. So,

        wip

    is your entry point (even though it doesn't show up with `which wip`).


Getting started:

  * If this is your *first* time installing `wip` on this machine, you need
    to `source ~/.wiprc` to get things activated for your current shell
    session(s).
  * Drop a `.wiprc` file into a project of your liking. Add some
    project-specific setup to that file. To start, try this:

        echo 'welcome to my cool project!'

  * Next these a try:

        wip help

        wip index ~/workspace
            # containing, perhaps, numerous 'works'
            # returns a list of work names and paths

        wip
            # shortcut for `wip index .`

        wip show WORK_NAME
            # cd's to known (indexed) work and sources .wiprc, e.g.:
            # welcome to my cool project!

        wip WORK_NAME
            # shortcut for `wip show`

        wip .
            # shortcut for `wip show .`


Feedback, complaints, suggestions, etc?

  * email me:  
    support+wip@coolerator.net

------------------------------------------------------------------------------
}

end
