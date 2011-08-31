require 'spec_helper'
require 'paperclip-thumbnailer/commands/command_center'

describe PaperclipThumbnailer::CommandCenter, 'builder' do
  let(:command1) { PaperclipThumbnailer::MockCommand.new('echo') }
  let(:command2) { PaperclipThumbnailer::MockCommand.new(':') }
  let(:source) { 'source' }
  let(:destination) { 'destination' }
  let(:expected_command) {
    %{echo #{source} -a b - | : - -c d #{destination}}
  }

  subject { PaperclipThumbnailer::CommandCenter.new([command1,command2]) }

  before do
    subject.
      with_source(source).
      with_destination(destination).
      for_command(:echo).
      with_configuration(:baz => :barney).
      with_flag(:a,'b').
      for_command(':'.to_sym).
      with_flag(:c,'d').
      with_configuration(:foo => :bar)
  end

  it "produces the expected string when built" do
    subject.to_s.should == expected_command
  end

  it "handles the options" do
    command1.should have_configuration(:baz => :barney)
    command2.should have_configuration(:foo => :bar)
  end

  it "understand the #run! message" do
    subject.should respond_to(:run!)
  end
end

describe PaperclipThumbnailer::CommandCenter, 'errors' do
  let(:command) { PaperclipThumbnailer::MockCommand.new('present') }

  subject { PaperclipThumbnailer::CommandCenter.new([command]) }

  it "raises" do
    lambda { subject.for_command(:missing) }.should raise_error
  end
end
