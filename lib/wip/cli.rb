$:.unshift File.expand_path('../vendor', __FILE__)
require 'thor'
require 'thor/actions'

# Work around a RubyGems bug
Gem.configuration

module WIP
  class CLI < Thor
    include Thor::Actions

    def initialize(*args)
      super
      use_shell = options["no-color"] ? Thor::Shell::Basic.new : shell

      WIP.ui = UI::Shell.new(use_shell)
      Gem::DefaultUserInteraction.ui = UI::RGProxy.new(WIP.ui)
    end

    desc "list", "List all indexed 'works'"
    def list(path)
      list_path = absolute(path)
      WIP.ui.info "Indexed 'works' within #{list_path}:"

      WIP.index.all.sort_by { |w| w[:name] }.each do |w|
        item_path = w[:path]

        if w[:path].match(/^#{list_path}.*/)
          WIP.ui.info "  * #{w[:name]}:\n    #{w[:path]}"
        end
      end
    end

    private

      def absolute(path)
        (path.match(/^\//) ? path : File.join(WIP.here, path)).sub(/\/$/, '')
      end
  end
end
