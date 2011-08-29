class MockFlags
  def initialize(args)
    @options = args
  end

  def has_flag?(flag)
    @options.has_key?(:flag)
  end
end
