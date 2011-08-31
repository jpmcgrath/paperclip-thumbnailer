require 'spec_helper'
require 'paperclip-thumbnailer/commands/composite_command'

describe PaperclipThumbnailer::CompositeCommand do
  subject { PaperclipThumbnailer::CompositeCommand.new }
  let(:tag) { :composite }

  it "has the appropriate tag" do
    subject.tag.should == tag
  end

  it "understands #for_command" do
    subject.for_command(:foo).should respond_to(:for_command)
  end

  it "understand the #run! message" do
    subject.should respond_to(:run!)
  end
end

describe PaperclipThumbnailer::CompositeCommand, 'builder' do
  subject { PaperclipThumbnailer::CompositeCommand.new }
  let(:source) { 'source' }
  let(:destination) { 'destination' }
  let(:expected_command) {
    %{composite a b c #{source} -a "b" -c d e f #{destination}}
  }

  before do
    subject.
      with_configuration(:source_file_options => %w(a b c)).
      with_configuration(:destination_file_options => %w(d e f)).
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

