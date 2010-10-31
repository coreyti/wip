module WIP
  module CLI
    class Index
      attr_reader :path

      def initialize(path)
        @path    = path
        @initial = File.exist?(index_file) ? YAML.load_file(index_file) : {}
      end

      def get(options = {})
        result = index.select do |entry|
          entry[:path].match(/^#{context}/)
        end

        return result.sort_by { |entry| entry[:"#{options[:sort]}"] } if options[:sort]
        return result
      end

      private

        def index
          home  = ENV['HOME']
          found = File.join(context, '**', '.wiprc')
          found = Dir.glob(found).inject({}) do |memo, entry|
            dirs = entry.split('/')[0...-1]
            path = dirs.join('/')

            unless path == home
              memo["#{dirs.last}"] = {
                "path" => path
              }
            end

            memo
          end

          works = (@initial || {}).merge(found)

          File.open(index_file, 'w') do |out|
            YAML.dump(works, out)
          end

          works.keys.map do |key|
            {
              :name => key,
              :path => works[key]['path']
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
