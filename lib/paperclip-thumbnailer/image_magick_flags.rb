module Paperclip
  module Thumbnailer

    class ImageMagickFlags
      attr_reader :source, :destination, :flags

      def initialize(options)
        @source_file_options = options[:source_file_options]
        @convert_options     = options[:convert_options]
        @flags = []
        @source = ""
        @destination = ""
      end

      def source_file_options
        @source_file_options || []
      end

      def convert_options
        @convert_options || []
      end

      def with_flag(flag, value = false)
        unless @flags.include?("-#{flag}")
          @flags << "-#{flag}"
          @flags << %{"#{value}"} if value
        end
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

      def to_s
        [source_file_options, source, flags, convert_options, destination].flatten.join(' ')
      end
    end

  end
end
