module WIP
  module CLI
    class Index < Base
      def initialize(*)
        super
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
          found = File.join(context, '**', '.wiprc')
          found = Dir.glob(found).inject({}) do |memo, entry|
            dirs     = entry.split('/')[0...-1]
            location = File.expand_path(dirs.join('/').sub(/\/\.?$/, ''))

            unless location == WIP.home
              memo["#{dirs.last}"] = {
                "path" => location
              }
            end

            memo
          end

          works = (config || {}).merge(found)
          cache = works.reject { |key, value| key == '.' }

          File.open(index_file, 'w') do |out|
            YAML.dump(cache, out)
          end

          works.keys.map do |key|
            {
              :name => key,
              :path => works[key]['path']
            }
          end
        end
    end
  end
end
