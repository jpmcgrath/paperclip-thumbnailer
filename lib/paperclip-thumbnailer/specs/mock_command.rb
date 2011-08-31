module PaperclipThumbnailer
  class MockCommand
    def with_source(source)
      @source = source
      self
    end

    def with_destination(destination)
      @destination = destination
      self
    end

    def with_options(options)
      @options = options
      self
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
