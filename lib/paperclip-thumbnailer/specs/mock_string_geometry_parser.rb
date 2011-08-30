module Paperclip
  module Thumbnailer

    class MockStringGeometryParser
      def initialize(geo)
        @geometry = geo
      end

      def parse(geometry)
        @geometry
      end
    end

  end
end
