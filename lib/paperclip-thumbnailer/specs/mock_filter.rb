require 'rspec/expectations'

module PaperclipThumbnailer
  class MockFilter
    def initialize
      @source = nil
      @destination = nil
      @options = nil
      @has_run = false
      @for_commands = []
      @flags = {}
      @options = {}
    end

    def command(source, destination, options)
      @source = source
      @destination = destination
      @options = options
      self
    end

    def run!
      @has_run = true
    end

    def has_run_command?(source, destination, options)
      @has_run && source == @source && destination == @destination && options == @options
    end

    def for_command(c)
      @for_commands << [c,{}]
      self
    end

    def with_flag(f,v=nil)
      if @for_commands[-1]
        @for_commands[-1][1][f] = v
      else
        @flags[f] = v
      end
      self
    end

    def with_options(options)
      @options = @options.merge(options)
      self
    end

    def flag(command, flag)
      if command
        commands = @for_commands.detect{|e,f| e==command}
        commands[1][flag] if commands
      else
        @flags[flag]
      end
    end

    def has_flag?(command, flag)
      if command
        commands = @for_commands.detect{|(e,f)| e==command}
        commands[1][flag] if commands
      else
        @flags[flag]
      end
    end

    def has_option?(option, value)
      @options.has_key?(option) && @options[option] == value
    end
  end
end

RSpec::Matchers.define :have_flag do|flag|
  match do |actual|
    actual.has_flag?(@command,flag) && (@value ? actual.flag(@command,flag) == @value : true)
  end

  chain :set_to do |value|
    @value = value
  end

  chain :for_command do |command|
    @command = command
  end
end
