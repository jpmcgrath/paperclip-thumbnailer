module Paperclip
  module Thumbnailer

    class Processor
      def self.build_from(filters)
        filter = filters[0..-2].reverse.inject(filters.last) do |acc,f|
          f.atop(acc)
        end
        new(filter)
      end

      def initialize(filter)
        @filter = filter
      end

      def make(file, options = {}, attachment = nil)
        destination_file = destination(file, options)
        cmd = @filter.command(source(file), File.expand_path(destination_file.path), options)

        `#{cmd.to_s}`

        destination_file
      end

      protected

      def source(file)
        File.expand_path(file.path)
      end

      def destination(file, options)
        format = options[:format]
        file_ext = File.extname(file.path)
        basename = File.basename(file.path, file_ext)

        Tempfile.new([basename, format ? ".#{format}" : '']).tap do |tmp|
          tmp.binmode
        end
      end
    end

  end
end
