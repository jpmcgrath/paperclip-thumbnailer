require 'paperclip-thumbnailer/processor'
require 'paperclip-thumbnailer/filters/thumbnailer_filter'
require 'paperclip-thumbnailer/filters/filter_terminus'
require 'paperclip-thumbnailer/commands/convert_command'
require 'paperclip'

module PaperclipThumbnailer
  ::Paperclip.configure do |c|
    c.register_processor :basic_thumbnailer,
      Processor.build_from(
        [ThumbnailerFilter.new,
          FilterTerminus.new(ConvertCommand.new)]
    )
  end
end
