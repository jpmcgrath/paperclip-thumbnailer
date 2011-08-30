require 'rspec'
require 'paperclip-thumbnailer/specs/mock_flags'

shared_examples "a combinable ImageMagick filter" do
  it "sets the filter using #atop" do
    base_filter = Object.new
    subject.atop(base_filter).should == subject
    subject.filter.should == base_filter
  end
end

shared_examples "an ImageMagick filter with a default command" do
  it "delegates to the base filter" do
    base_filter = Class.new do
      def command(source,destination, options)
        [source,destination, options]
      end
      def flags(options)
        options.is_a?(Hash) ? Paperclip::Thumbnailer::MockFlags.new(options) : options
      end
    end.new
    source = 'file'
    destination = 'file'
    options = {:a => 1}

    subject.atop(base_filter)

    subject.command(source, destination, options).should == base_filter.command(source, destination, subject.flags(options))
  end
end
