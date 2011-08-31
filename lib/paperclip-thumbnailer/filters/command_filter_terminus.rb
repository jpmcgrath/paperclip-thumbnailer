module Paperclip
  module Thumbnailer

    class CommandFilterTerminus
      def initialize(command_pipe)
        @command = command_pipe
      end

      def command(source, destination, options)
        @command.
          with_source(source).
          with_destination(destination).
          with_options(options)
      end
    end

  end
end
