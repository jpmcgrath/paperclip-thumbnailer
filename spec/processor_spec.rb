require 'spec_helper'
require 'paperclip-thumbnailer/processor'

describe Paperclip::Thumbnailer::Processor do
  let(:file) { File.open(File.join(PROJECT_ROOT, 'Gemfile')) }
  let(:filter) do
    Class.new do
      def atop(filter)
        self
      end

      def command(s,d, o)
        "whoami"
      end
    end.new
  end
  subject { Paperclip::Thumbnailer::Processor.new(filter) }

  it_behaves_like "a Paperclip processor"

  it "runs the filter's command" do
    lambda { subject.make(file) }.should_not raise_error
  end
end

describe Paperclip::Thumbnailer::Processor, "building" do
  let(:top_filter) do
    Class.new do
      def atop(f)
        @filter = f
        self
      end
      def filter
        @filter
      end
      def flags(options)
        filter.flags(options)
      end
      def command(file, options)
        filter.command(file, options)
      end
    end.new
  end
  let(:bottom_filter) do
    Class.new do
      def atop(f)
        @filter = f
        self
      end
      def filter
        @filter
      end
      def flags(options)
        []
      end
      def command(file, options)
        ""
      end
    end.new
  end

  it "can be build from composing filters" do
    processor = Paperclip::Thumbnailer::Processor.build_from([top_filter, bottom_filter])
    processor.should respond_to(:make)
  end
end
