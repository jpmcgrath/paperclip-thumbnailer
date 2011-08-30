require 'tempfile'
require 'cocaine'
require 'paperclip-thumbnailer/image_magick_flags'

module Paperclip
  module Thumbnailer

    class ImageMagickFilter
      def initialize(image_magick_flags = false)
        @image_magick_flags = image_magick_flags || ImageMagickFlags
      end

      def atop(filter)
        @filter = filter
        self
      end

      def filter
        @filter
      end

      def flags(options)
        options.is_a?(Hash) ? @image_magick_flags.new(options) : options
      end

      def command(source, destination, options)
        cmd = flags(options).with_source(source).with_destination(destination)
        Cocaine::CommandLine.new("convert", cmd.to_s).command
      end

    end

  end
end
