paperclip-thumbnailer
=====================

A gem in four parts.

This gem provides a Paperclip processor named `:basic_thumbnailer`. You can use it like this:

    gem 'paperclip-thumbnailer'
  
    has_attached_file :avatar,
                      :styles => {:medium => '100x100'},
                      :processors => [:basic_thumbnailer]

It thumbnails things in the most boring way possible.

This gem is mainly for building other Paperclip processors.

Building Blocks
---------------

The major building blocks are the `Processor`, the filters, and the commands. Filters are composable classes which know how to build a command. The `Processor` takes a bunch of filters and produces an object that Paperclip can use for post-processing.

Here's an example, which will produce what is essentially a no-op processor:

    Processor.build_from([FilterTerminus.new(ConvertCommand.new)])

(It will actually pipe the file though the `convert` program, but do nothing to it in the process.)

Here's a more complex example:

    Processor.build_from(
      [ThumbnailerFilter.new,
       WatermarkerFilter.new,
       FilterTerminus.new(
         CommandCenter.new(
           [ConvertCommand.new,
            CompositeCommand.new]))])

This example will build a Paperclip processor that pipes a file through the `convert` and `composite` programs, with flags decided by the ThumbnailerFilter and WatermarkerFilter filters, in that order.

Processor
---------

The `PaperclipThumbnailer::Processor` class is a Paperclip processor. A Paperclip processor is any object that responds to the `#make` method. The `PaperclipThumbnailer::Processor` knows how to build a Paperclip processor from a bunch of filters.

The `PaperclipThumbnailer::Processor.build_from` method takes a list of filters. The last element in the list must be a filter terminus; all other filters will chain atop that.

Let's take the complex example above:

    Processor.build_from(
      [ThumbnailerFilter.new,
       WatermarkerFilter.new,
       FilterTerminus.new(
         CommandCenter.new(
           [ConvertCommand.new,
            CompositeCommand.new]))])

This will build a new PaperclipThumbnailer::Processor like this:

    base_command = CommandCenter.new([ConvertCommand.new, CompositeCommand.new])
    thumbnailer_filter = ThumbnailerFilter.new
    watermarker_filter = WatermarkerFilter.new
    terminus = FilterTerminus.new(base_command)
    Processor.new(thumbnailer_filter.atop(watermarker_filter.atop(terminus)))

This new processor is ready to use as a Paperclip processor.

Filter
------

An individual filter knows how to do two things: stand atop another filter, and produce a command object. It is most likely and expected that you, the developer, will write a filter.

All filters except for terminus filters must define a method named `#atop`:

    class SepiaFilter
      def atop(filter)
        @filter = filter
      end
    end

This method is passed another filter, which may or may not be a terminus. This filter knows how to construct a command object which you can build upon.

    class SepiaFilter
      def command(source, destination, options)
        @filter.command(source, destination, options).
          for_command(:convert).
          with_flag('sepia-tone', 20)
      end
    end

The `#command` method must produce an object that responds to the `#run!` method. We provide three useful examples of such command objects.

Command
-------

A command object is an object that responds to the `#run!` method. To be most useful it must also respond to the following methods:

* `#for_command`
* `#with_source`
* `#with_destination`
* `#with_configuration`
* `#with_flag`

All of the above commands must produce an object which will also respond to those commands.

As the simplest possible example:

    class IdentityCommand
      def run!
      end

      def for_command(tag)
        self
      end

      def with_source(source)
        self
      end

      def with_destination(destination)
        self
      end

      def with_configuration(config)
        self
      end

      def with_flag(flag, value = nil)
        self
      end
    end

As a special case when making a command object that actually runs a command on the shell you should also define the `#to_s` and `#tag` methods. See the `PaperclipThumbnailer::CommandCenter` class for examples of how those are used.

    class IdentityCommand
      def tag
        :identity
      end

      def to_s
        "echo"
      end
    end

Testing
-------

You should unit test these filters and custom commands in the normal manner. Everything except `#run!` produces a queryable object. We also provide some mock objects and shared examples to make this easier.

Supplied Testing Parts
----------------------

The `paperclip-thumbnailer/specs` directory contains mock objects and shared examples.

To use the "a combinable filter" shared example you must set a subject to an instance of a filter with no base. It takes care of the rest:

    describe SepiaFilter do
      subject { SepiaFilter.new }
      it_behaves_like "a combinable filter"
    end

There is also an "a Paperclip processor" shared example which can be used to make sure that a given subject is a Paperclip processor. This is of questionable use.

The `PaperclipThumbnailer::MockFilter` object can be used as a sample filter that your filter sits atop. Using it also gives you access to the `have_flag` RSpec matcher, which works like this:

    describe SepiaFilter do
      let(:file) { 'file' }
      let(:options) { {:a => 1} }
      let(:filter) { SepiaFilter.new }
      subject { filter.command(file, file, options) }
      before { subject.atop(PaperclipThumbnailer::MockFilter.new) }

      it "sets some stuff" do
        subject.should have_flag(:resize).set_to('100x100').for_command(:convert)
        subject.should have_configuration(:a, 1)
      end
    end

The `PaperclipThumbnailer::MockCommand` object can be used as a base command. It is useful for testing a complete processor, for building a filter terminus, or for building command objects that wrap command objects.

Supplied Filter Parts
---------------------

We provide a basic `PaperclipThumbnailer::FilterTerminus` class and a sample `PaperclipThumbnailer::ThumbnailFilter` class. The provided filter terminus adds the source and destination to the command object. The thumbnail filter sets the resize flag for the `convert` command.

Supplied Command Parts
----------------------

We provide two ImageMagick-based command-line command objects, plus a class for piping command-line command objects together.

The `PaperclipThumbnailer::ConvertCommand` and `PaperclipThumbnailer::CompositeCommand` classes are wrappers for setting flags, sources, and destinations for the ImageMagick `convert` and `composite` commands, respectively.

The `PaperclipThumbnailer::CommandCenter` class takes a list of command classes and chains them using the shell pipe, `|` . For example:

    CommandCenter.new([ConvertCommand.new, CompositeCommand.new])

You can set flags on specific commands using the `#for_command` method and specifying the relevant tag.

    command_center.for_command(:convert).with_flag(:resize, '100x100').for_command(:composite).with_flag(:sepia, 20)

License and Copyright
---------------------

Copyright 2011 [thoughtbot](http://thoughtbot.com/). Licensed under the MIT license.

Original written by Mike Burns. For support please [open a Github Issue](https://github.com/thoughtbot/paperclip-thumbnailer/issues).
