module WIP
  module CLI
    class Exec # < Base
      def initialize(*)
        @_executor = Module.new
        @_executor.module_exec { load('.wiprc') }
      end

      def get(*args)
        command = args.shift.intern
        @_executor.send(command, *args)
      rescue NoMethodError
        puts "[FAIL] '#{command}' is not defined (add it to ./.wiprc)"
      end
    end
  end
end
