module WIP
  module CLI
    class Base
      attr_reader :path, :config

      def initialize(path)
        @path   = path
        @config = File.exist?(index_file) ? YAML.load_file(index_file) : {}
      end

      def get(options = {})
        raise NotImplementedError
      end

      protected

        def index_file
          Pathname.new(File.join(WIP.home, ".wip/index"))
        end

        def context
          File.expand_path(path.match(/^\//) ? path : File.join(WIP.here, path)).sub(/\/\.?$/, '')
        end
    end
  end
end
