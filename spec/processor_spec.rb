require 'spec_helper'
require 'paperclip-thumbnailer/processor'

describe PaperclipThumbnailer::Processor do
  let(:file) { File.open(File.join(PROJECT_ROOT, 'Gemfile')) }
  let(:options) { {:a => 1} }
  let(:attachment) { 'attachment' }
  let(:filter) { PaperclipThumbnailer::MockFilter.new }

  subject { PaperclipThumbnailer::Processor.new(filter) }

  it_behaves_like "a Paperclip processor"

  it "runs the filter's command" do
    destination_file = subject.make(file, options, attachment)

    destination_file.should respond_to(:close)
    destination_file.should respond_to(:path)
    filter.should have_run_command(File.expand_path(file.path),
                                   File.expand_path(destination_file.path),
                                   options)
  end
end

describe PaperclipThumbnailer::Processor, "building" do
  let(:top_filter) do
    Class.new do
      def atop(f)
        @filter = f
        self
      end
      def command(source, destination, options)
        @subfilter_command = @filter.command(source, destination, options)
        @source = source
        @destination = destination
        @options = options
        self
      end
      def run!
        @has_run = true
      end
      def has_run_command?(source, destination, options)
        @has_run &&
          @subfilter_command &&
          @subfilter_command.has_run_command?(source, destination, options) &&
          source == @source &&
          destination == @destination &&
          options == @options
      end
    end.new
  end
  let(:bottom_filter) do
    Class.new do
      attr_reader :source, :destination, :options
      def atop(f)
        @filter = f
        self
      end
      def command(source, destination, options)
        @source = source
        @destination = destination
        @options = options
        self
      end
      def has_run_command?(source, destination, options)
        source == @source && destination == @destination && options == @options
      end
    end.new
  end
  let(:file) { File.open(File.join(PROJECT_ROOT, 'Gemfile')) }
  let(:options) { {:a => 1} }
  let(:attachment) { 'attachment' }

  subject { PaperclipThumbnailer::Processor.build_from([top_filter, bottom_filter]) }

  it "can be build from composing filters" do
    destination_file = subject.make(file, options, attachment)
    top_filter.should have_run_command(File.expand_path(file.path),
                                       File.expand_path(destination_file.path),
                                       options)
  end
end
