require 'bundler'
Bundler::GemHelper.install_tasks

module Bundler
  class GemHelper
    # override in order to see install output (we have a post-install hook)
    def install_gem
      built_gem_path = build_gem
      out, err, code = sh_with_code("gem install #{built_gem_path}")
      puts out
      raise err if err[/ERROR/]
      Bundler.ui.confirm "#{name} (#{version}) installed"
    end
  end
end
