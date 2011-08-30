module Paperclip
  module Thumbnailer

    class ThumbnailerFilter
      def atop(filter)
        @filter = filter
        self
      end

      def filter
        @filter
      end

      def command(source, destination, options)
        filter.command("#{source}[0]", destination, flags(options))
      end

      def flags(options)
        filter.flags(options).with_flag(:resize, options[:geometry])
      end
    end

  end
end
