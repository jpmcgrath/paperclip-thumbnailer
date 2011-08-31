module Paperclip
  module Thumbnailer

    class ThumbnailerFilter
      def atop(filter)
        @filter = filter
        self
      end

      def command(source, destination, options)
        new_source = "#{source}[0]"

        @filter.command(new_source, destination, options).tap do |cmd|
          cmd.for_command(:convert).with_flag(:resize, options[:geometry])
        end
      end
    end

  end
end
