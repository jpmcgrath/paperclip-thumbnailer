module Paperclip
  module Thumbnailer

    class MockFileGeometryParser
      def initialize(geo)
        @geometry = geo
      end

      def from_file(file)
        @geometry
      end
    end

  end
end
