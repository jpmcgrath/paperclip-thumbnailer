module Paperclip
  module Thumbnailer

    class CommandCenter
      def initialize(commands)
        @commands = commands
      end

      def for_command(tag)
        @commands.detect {|command| command.tag == tag}
      end

      def with_source(source)
        @commands[0].with_source(source)
        self
      end

      def with_destination(destination)
        @commands[-1].with_destination(destination)
        self
      end

      def with_options(options)
        @commands.each {|command| command.with_options(options)}
        self
      end

      def to_s
        @commands[0..-2].each {|command| command.with_destination('-')}
        @commands[1..-1].each {|command| command.with_source('-')}

        @commands.map{|command| command.to_s}.join(' | ')
      end
    end

  end
end
