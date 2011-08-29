require 'spec_helper'
require 'paperclip-thumbnailer/filters/thumbnailer_filter'

describe ThumbnailerFilter do
  let(:geometry) { "80x20" }
  let(:options) do
    { :file_geometry_parser   => MockFileGeometryParser.new('100x200'),
      :string_geometry_parser => MockStringGeometryParser.new(geometry),
      :geometry => geometry }
  end

  subject do
    ThumbnailerFilter.new.tap do |tf|
      tf.atop(MockBaseFilter.new)
    end
  end

  it_behaves_like "a combinable ImageMagick filter"
  it_behaves_like "an ImageMagick filter with a default command"

  it "sets the resize flag correctly" do
    subject.flags(options).should have_flag(:resize).set_to("80x20")
  end
end
