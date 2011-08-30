module Paperclip
  module Thumbnailer

    class MockFlags
      attr_accessor :flags, :source, :destination
      def initialize(args)
        @flags = {}
        @source = nil
        @destination = nil
      end

      def has_flag?(flag)
        @flags.has_key?(flag)
      end

      def empty_flags?
        @flags.empty?
      end

      def has_destination_flag?(dest)
        @destination == dest
      end

      def with_source(s)
        @source = s
        self
      end

      def with_destination(d)
        @destination = d
        self
      end

      def with_flag(flag, value=nil)
        @flags[flag] = value
        self
      end

      def flag(f)
        @flags[f]
      end

      def ==(o)
        o.flags == flags && o.source == source && o.destination == destination
      end

      def to_s
        [source, flags.map{|f,v| "-#{f}=#{v}"}, destination].flatten.join(' ')
      end
    end

  end
end
