require 'rspec'

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
      def command(file, options)
        [file, options]
      end
    end.new
    file = 'file'
    options = {:a => 1}

    subject.atop(base_filter)

    subject.command(file, options).should == base_filter.command(file, options)
  end
end
