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
        `#{@filter.command(file, options)}`
      end
    end

  end
end
