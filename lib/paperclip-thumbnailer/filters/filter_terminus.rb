module PaperclipThumbnailer

  class FilterTerminus
    def initialize(command_pipe)
      @command = command_pipe
    end

    def command(source, destination, options)
      @command.
        with_source(source).
        with_destination(destination).
        with_configuration(options)
    end
  end

end
