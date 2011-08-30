require 'paperclip-thumbnailer/specs/mock_flags'

module Paperclip
  module Thumbnailer

    class MockBaseFilter
      def flags(options)
        MockFlags.new(options)
      end

      def command(source, destination, options)
        "echo " + options.with_source(source).with_destination(destination).to_s
      end
    end

  end
end
