# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "wip/version"

BOOTSTRAP_VERSION = "1.1"

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

Please Note:

`wip` (for now) depends on `wip-bootstrap`. If you didn't already have the
necessary version of `wip-bootstrap` installed, you should see a short banner
just above this, indicating that you need to run

    wip-bootstrap

If so, please run that now and then `source ~/.wiprc` to get set up.

`wip-bootstrap` shouldn't have to be updated too often, so this step will be
infrequent, even when you update `wip` (proper).


For more info on `wip`, see <http://github.com/coreyti/wip>


Feedback, complaints, suggestions, etc?

  * email me:  
    support+wip@coolerator.net

------------------------------------------------------------------------------
}

end
