require 'paperclip-thumbnailer/specs/mock_flags'

class MockBaseFilter
  def flags(options)
    MockFlags.new(options)
  end
end
