class ThumbnailerFilter
  def atop(filter)
    @filter = filter
  end

  def filter
    @filter
  end

  def command(file, options)
    filter.command(file, options)
  end

  def flags(options)
    filter.flags(options)
  end
end
