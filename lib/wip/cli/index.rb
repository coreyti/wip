module WIP
  module CLI
    class Index
      attr_reader :path

      def initialize
        @index = File.exist?(index_file) ? YAML.load_file(index_file) : {}
      end

      def get(path, options = {})
        @path  = path
        result = index_cache.select do |entry|
          entry[:path].match(/^#{context}/)
        end

        return result.sort_by { |entry| entry[:"#{options[:sort]}"] } if options[:sort]
        return result
      end

      def set(path)
        wips = File.join(context, '**', '.wiprc')
        wips = Dir.glob(wips).inject({}) do |memo, entry|
          dirs = entry.split('/')[0...-1]
          memo["#{dirs.last}"] = {
            "path" => dirs.join('/')
          }
          memo
        end

        File.open(index_file, 'w') do |out|
          YAML.dump(wips, out)
        end
      end

      private

        def index_cache
          @_index_cache ||= @index.keys && @index.keys.map do |key|
            {
              :name => key,
              :path => @index[key]['path']
            }
          end
        end

        def index_file
          Pathname.new(File.join(Gem.user_home, ".wip/index"))
        end

        def context
          (path.match(/^\//) ? path : File.join(WIP.here, path)).sub(/\/$/, '')
        end
    end
  end
end
