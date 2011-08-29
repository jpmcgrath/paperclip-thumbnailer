class MockFlags
  def initialize(args)
    @options = args
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
end
