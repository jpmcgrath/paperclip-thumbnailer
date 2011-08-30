require 'paperclip-thumbnailer/specs/mock_flags'

module Paperclip
  module Thumbnailer

    class MockBaseFilter
      def flags(options)
        MockFlags.new(options)
      end

      def command(file, options)
        "echo #{file} #{options.inspect}"
      end
    end

  end
end
