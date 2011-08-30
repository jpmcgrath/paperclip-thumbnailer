require 'spec_helper'
require 'paperclip-thumbnailer/image_magick_flags'

describe Paperclip::Thumbnailer::ImageMagickFlags, 'source file options' do
  it "produces the source file options when those are set" do
    source_file_options = %w(a b c)
    flags = Paperclip::Thumbnailer::ImageMagickFlags.new(:source_file_options => source_file_options)
    flags.source_file_options.should == source_file_options
  end

  it "produces the empty list when the source file options are unset" do
    flags = Paperclip::Thumbnailer::ImageMagickFlags.new({})
    flags.source_file_options.should == []
  end
end

describe Paperclip::Thumbnailer::ImageMagickFlags, 'convert options' do
  it "produces the convert options when they are set" do
    convert_options = %w(a b d)
    flags = Paperclip::Thumbnailer::ImageMagickFlags.new(:convert_options => convert_options)
    flags.convert_options.should == convert_options
  end

  it "produces the empty list when the convert options are unset" do
    flags = Paperclip::Thumbnailer::ImageMagickFlags.new({})
    flags.convert_options.should == []
  end
end

describe Paperclip::Thumbnailer::ImageMagickFlags, 'builder' do
  subject { Paperclip::Thumbnailer::ImageMagickFlags.new({}) }

  it "produces itself from #with_flag" do
    subject.with_flag(:a, 'b').should == subject
    subject.with_flag(:a).should == subject
  end

  it "produces itself from #with_source" do
    subject.with_source('a').should == subject
  end

  it "produces itself from #with_destination" do
    subject.with_destination('a').should == subject
  end
end

describe Paperclip::Thumbnailer::ImageMagickFlags do
  let(:source_file_options) { %w(a b c) }
  let(:convert_options) { %w(d e f) }
  let(:source) { 'k' }
  let(:destination) { 'j' }

  subject do
    Paperclip::Thumbnailer::ImageMagickFlags.
      new(:source_file_options => source_file_options,
          :convert_options => convert_options).
      with_flag(:g, 'h').
      with_flag(:i).
      with_destination(destination).
      with_source(source)
  end

  let(:expected) do
    %{a b c k -g "h" -i d e f j}
  end

  it "produces the expected string as a result" do
    subject.to_s.should == expected
  end

  context 'accessors' do
    it 'has a #source' do
      subject.source.should == source
    end

    it 'has a destination' do
      subject.destination.should == destination
    end

    it 'has flags' do
      subject.flags.should == ['-g', '"h"', '-i']
    end
  end
end

describe Paperclip::Thumbnailer::ImageMagickFlags, 'overriding' do
  subject { Paperclip::Thumbnailer::ImageMagickFlags.new({}).with_flag(:a, 'b').with_flag(:a, 'c') }

  it "only takes the very first flag set" do
    subject.flags.should == ['-a', '"b"']
  end
end
