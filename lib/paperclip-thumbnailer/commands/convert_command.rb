module PaperclipThumbnailer

  class ConvertCommand
    def initialize
      @flags = []
      @options = {}
    end

    def tag
      :convert
    end

    def for_command(tag)
      self
    end

    def with_options(options)
      @options = @options.merge(options)
      self
    end

    def with_source(source)
      @source = source
      self
    end

    def with_destination(destination)
      @destination = destination
      self
    end

    def with_flag(arg, value = false)
      unless @flags.include?("-#{arg}")
        @flags << "-#{arg}"
        @flags << %{"#{value}"} if value
      end
      self
    end

    def to_s
      "convert " + [source_file_options, source, flags, destination_file_options, destination].flatten.join(' ')
    end

    def run!
      `#{to_s}`
    end

    protected

    attr_reader :source, :destination, :flags

    def source_file_options
      @options[:source_file_options] || []
    end

    def destination_file_options
      @options[:destination_file_options] || []
    end
  end

end
