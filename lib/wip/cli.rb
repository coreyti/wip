$:.unshift File.expand_path('../vendor', __FILE__)
require 'thor'
require 'thor/actions'

# begin
#   require 'wip-bootstrap'
#   WIP::Bootstrap.run
# rescue
#   raise 'Failed to bootstrap `wip`.'
# end

# Work around a RubyGems bug
Gem.configuration

module WIP
  module CLI
    autoload :Base,  'wip/cli/base'
    autoload :Index, 'wip/cli/index'
    autoload :Show,  'wip/cli/show'

    class Shell < Thor
      include Thor::Actions

      def initialize(*args)
        super
        use_shell = options["no-color"] ? Thor::Shell::Basic.new : shell

        WIP.ui = UI::Shell.new(use_shell)
        Gem::DefaultUserInteraction.ui = UI::RGProxy.new(WIP.ui)
      end

      check_unknown_options!

      desc "route", "Route finder", :hide => true
      def route(*args)
        @_all_tasks    ||= self.class.all_tasks
        @_public_names ||= @_all_tasks.inject([]) do |memo, hash|
          memo << hash[0] unless hash[1].hidden?
          memo
        end

        # TODO: be sure we cannot loop (send :route)
        if @_public_names.include?(args.first)
          send(args.shift, *args)
        else
          # no matching task: see if there's a "work" to show
          show(*args)
        end
      end

      desc "index", "List all indexed 'works'"
      method_option "path", :type    => :string,
                            :banner  => "Specify a path to index",
                            :default => '. (working dir)'
      def index(path = nil, *)
        @_index ||= WIP::CLI::Index.new(path || '.')
        @_index.get(:sort => :name).each do |work|
          WIP.ui.info "  * #{work[:name]}\n    #{work[:path]}"
        end
      end

      desc "show", "Move to and activate a 'work'"
      method_option "path", :type    => :string,
                            :banner  => "Specify a path to activate",
                            :default => '. (working dir)'
      def show(path = nil, *)
        @_show ||= WIP::CLI::Show.new(path || '.')
        WIP.ui.info @_show.get
      end

      desc "back", "Move to and activate most recent 'work'"
      def back(*)
        WIP.ui.info ENV['WIP_BACK']
      end
    end
  end
end
