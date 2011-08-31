module PaperclipThumbnailer

  class CommandCenter
    def initialize(commands)
      @commands = commands
    end

    def for_command(tag)
      subcommand = @commands.detect {|command| command.tag == tag}
      if subcommand
        ForCommand.new(self, subcommand)
      else
        raise IndexError, "no command with tag #{tag} in the CommandCenter"
      end
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

    def run!
      `#{to_s}`
    end
  end


  class ForCommand
    def initialize(parent, command)
      @parent = parent
      @command = command
    end

    def with_flag(f,v=nil)
      @command.with_flag(f,v)
      self
    end

    def for_command(command_name)
      @parent.for_command(command_name)
    end

    def method_missing(method_name, *args, &block)
      @parent.send(method_name,*args,&block)
    end
  end
end
