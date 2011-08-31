require 'rspec'

shared_examples "a combinable filter" do
  it "delegates to the base filter" do
    base_filter = Class.new do
      attr_reader :args
      def command(source,destination, options)
        @args = [source,destination, options]
        @was_invoked = true
        self
      end
      def for_command(t)
        self
      end
      def with_flag(f,v=nil)
        self
      end
      def with_options(o)
        self
      end
      def invoked?
        @was_invoked
      end
    end.new
    source = 'file'
    destination = 'file'
    os = if defined?(options)
           options
         else
           {:a =>1}
         end

    subject.atop(base_filter).command(source, destination, os)

    base_filter.should be_invoked
  end
end
