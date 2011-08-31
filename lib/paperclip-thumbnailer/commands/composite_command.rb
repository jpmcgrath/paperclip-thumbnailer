module Paperclip
  module Thumbnailer

    class CompositeCommand
      def initialize
        @flags = []
        @options = {}
      end

      def tag
        :composite
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
        "composite " + [source_file_options, source, flags, convert_options, destination].flatten.join(' ')
      end

      protected

      attr_reader :source, :destination, :flags

      def source_file_options
        @options[:source_file_options]
      end

      def convert_options
        @options[:convert_options]
      end
    end

  end
end
