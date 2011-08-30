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
        @image_magick_flags.new(options)
      end

      def command(file, options)
        cmd = flags(options).
          with_source(source(file)).
          with_destination(destination(file, options))
        Cocaine::CommandLine.new("convert", cmd.to_s).command
      end

      def source(file)
        "#{File.expand_path(file.path)}[0]"
      end

      def destination(file, options)
        format = options[:format]
        file_ext = File.extname(file.path)
        basename = File.basename(file.path, file_ext)

        tmp = Tempfile.new([basename, format ? ".#{format}" : ''])
        tmp.binmode

        File.expand_path(tmp.path)
      end
    end

  end
end
