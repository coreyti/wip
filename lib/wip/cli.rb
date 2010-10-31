$:.unshift File.expand_path('../vendor', __FILE__)
require 'thor'
require 'thor/actions'

# Work around a RubyGems bug
Gem.configuration

module WIP
  module CLI
    autoload :Index, 'wip/cli/index'

    class Shell < Thor
      include Thor::Actions

      def initialize(*args)
        super
        use_shell = options["no-color"] ? Thor::Shell::Basic.new : shell

        WIP.ui = UI::Shell.new(use_shell)
        Gem::DefaultUserInteraction.ui = UI::RGProxy.new(WIP.ui)
      end

      check_unknown_options!

      desc "index", "List all indexed 'works'"
      method_option "path", :type    => :string,
                            :banner  => "Specify a path to index",
                            :default => '. (working dir)'
      def index(path = nil)
        @_index ||= WIP::CLI::Index.new(path || '.')
        @_index.get(:sort => :name).each do |work|
          WIP.ui.info "  * #{work[:name]}\n    #{work[:path]}"
        end
      end
    end
  end
end
