module WIP
  class Index
    attr_reader :index

    def initialize
      @index = File.exist?(index_file) ? YAML.load_file(index_file) : {}
    end

    def all
      index.keys.map do |key|
        { :name => key, :path => index[key]['path'] }
      end
    end

    private

      def index_file
        Pathname.new(File.join(Gem.user_home, ".wip/index"))
      end
  end
end
