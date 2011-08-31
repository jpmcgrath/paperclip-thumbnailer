require 'spec_helper'
require 'paperclip-thumbnailer/commands/convert_command'

describe PaperclipThumbnailer::ConvertCommand do
  subject { PaperclipThumbnailer::ConvertCommand.new }
  let(:tag) { :convert }

  it "has the appropriate tag" do
    subject.tag.should == tag
  end

  it "understands #for_command" do
    subject.for_command(:foo).should respond_to(:for_command)
  end
end

describe PaperclipThumbnailer::ConvertCommand, 'builder' do
  subject { PaperclipThumbnailer::ConvertCommand.new }
  let(:source) { 'source' }
  let(:destination) { 'destination' }
  let(:expected_command) {
    %{convert a b c #{source} -a "b" -c d e f #{destination}}
  }

  before do
    subject.
      with_options(:source_file_options => %w(a b c)).
      with_options(:destination_file_options => %w(d e f)).
      with_source(source).
      with_destination(destination).
      with_flag(:a, 'b').
      with_flag(:c).
      with_flag(:a, 'd')
  end

  it "should produce the expected command" do
    subject.to_s.should == expected_command
  end
end
