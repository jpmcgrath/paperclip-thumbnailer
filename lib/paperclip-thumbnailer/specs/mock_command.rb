module PaperclipThumbnailer
  class MockCommand
    def initialize(program_name)
      @program_name = program_name
      @flags = []
      @options = {}
    end

    def tag
      @program_name.to_sym
    end

    def with_source(source)
      @source = source
      self
    end

    def with_destination(destination)
      @destination = destination
      self
    end

    def with_configuration(options)
      @options = @options.merge(options)
      self
    end

    def with_flag(f,v=nil)
      @flags << "-#{f}"
      @flags << v if v
    end

    def to_s
      [@program_name,@source,@flags,@destination].flatten.join(' ')
    end

    def has_source?(source)
      @source == source
    end

    def has_destination?(destination)
      @destination == destination
    end

    def has_options?(options)
      @options == options
    end
  end
end
