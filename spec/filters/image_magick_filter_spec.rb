require 'spec_helper'
require 'paperclip-thumbnailer/filters/image_magick_filter'
require 'paperclip-thumbnailer/image_magick_flags'

describe ImageMagickFilter, 'with a mock flag builder' do
  let(:geometry) { "80x20" }
  let(:options) do
    { :file_geometry_parser   => MockFileGeometryParser.new('100x200'),
      :string_geometry_parser => MockStringGeometryParser.new(geometry),
      :geometry => geometry }
  end

  subject { ImageMagickFilter.new(MockFlags) }

  it_behaves_like "a combinable ImageMagick filter"

  it "produces an empty set of #flags" do
    subject.flags(options).should be_empty_flags
  end
end

describe ImageMagickFilter, 'with the default flag builder' do
  let(:expected_command) { %r{^convert #{file.path}\[0\] /tmp} }
  let(:options) { {} }
  let(:file) { File.new(File.join(PROJECT_ROOT, 'Gemfile')) }
  subject { ImageMagickFilter.new }

  it "produces the empty ImageMagickFlags instance on as the #flags" do
    subject.flags({}).should.to_s == ImageMagickFlags.new({}).to_s
  end

  it "produces the appropriate #command" do
    subject.command(file, options).should match(expected_command)
  end
end
