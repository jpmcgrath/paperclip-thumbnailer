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

      def command(file, options)
        filter.command(file, options)
      end

      def flags(options)
        filter.flags(options).with_flag(:resize, options[:geometry])
      end
    end

  end
end
