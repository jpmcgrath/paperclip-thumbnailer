require 'spec_helper'
require 'paperclip-thumbnailer/filters/filter_terminus'

describe PaperclipThumbnailer::FilterTerminus do
  let(:command) { PaperclipThumbnailer::MockCommand.new('echo') }
  let(:filter) { PaperclipThumbnailer::FilterTerminus.new(command) }
  let(:source) { 'source' }
  let(:destination) { 'destination' }
  let(:options) { { :a => 1 } }

  subject { filter.command(source, destination, options) }

  it "sets the source, destination, and options for the given command" do
    subject.should have_source(source)
    subject.should have_destination(destination)
    subject.should have_options(options)
  end
end
