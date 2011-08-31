require 'spec_helper'
require 'paperclip-thumbnailer/filters/thumbnailer_filter'

describe PaperclipThumbnailer::ThumbnailerFilter do
  subject { PaperclipThumbnailer::ThumbnailerFilter.new }
  it_behaves_like "a combinable filter"
end

describe PaperclipThumbnailer::ThumbnailerFilter do
  let(:geometry) { "80x20" }
  let(:options) do
    { :geometry => geometry }
  end
  let(:file) { 'file' }

  subject do
    PaperclipThumbnailer::ThumbnailerFilter.new.tap do |tf|
      tf.atop(PaperclipThumbnailer::MockFilter.new)
    end
  end

  it "sets the resize flag correctly" do
    subject.command(file, file, options).should have_flag(:resize).set_to("80x20").for_command(:convert)
  end
end
