module PaperclipThumbnailer
  class MockFilter
    def initialize
      @source = nil
      @destination = nil
      @options = nil
      @has_run = false
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
  end
end
