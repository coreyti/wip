module WIP
  module CLI
    class Show < Base
      def initialize(*)
        super
      end

      def get(options = {})
        locate_by_name ||
        locate_by_ctxt
      end

      private

        def locate_by_name
          found = config[path]
          found && found['path']
        end

        def locate_by_ctxt
          found = config.select do |key, value|
            key == context.split('/').last && config[key]['path'] == context
          end.flatten

          found.last['path'] unless found.empty?
        end
    end
  end
end
