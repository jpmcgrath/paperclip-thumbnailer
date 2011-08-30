require 'spec_helper'
require 'paperclip-thumbnailer/filters/thumbnailer_filter'

describe Paperclip::Thumbnailer::ThumbnailerFilter do
  let(:geometry) { "80x20" }
  let(:options) do
    { :file_geometry_parser   => Paperclip::Thumbnailer::MockFileGeometryParser.new('100x200'),
      :string_geometry_parser => Paperclip::Thumbnailer::MockStringGeometryParser.new(geometry),
      :geometry => geometry }
  end
  let(:file) { 'file' }
  let(:expected_command) { "echo #{file}[0] -resize=#{geometry} #{file}" }

  subject do
    Paperclip::Thumbnailer::ThumbnailerFilter.new.tap do |tf|
      tf.atop(Paperclip::Thumbnailer::MockBaseFilter.new)
    end
  end

  it_behaves_like "a combinable ImageMagick filter"

  it "sets the source to the first frame in the command" do
    subject.command(file, file, options).should == expected_command
  end

  it "sets the resize flag correctly" do
    subject.flags(options).should have_flag(:resize).set_to("80x20")
  end
end
