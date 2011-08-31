require 'paperclip-thumbnailer/processor'
require 'paperclip-thumbnailer/filters/thumbnailer_filter'
require 'paperclip-thumbnailer/filters/command_filter_terminus'
require 'paperclip-thumbnailer/commands/convert_command'

module Paperclip
  module Thumbnailer

    Thumbnail = Processor.build_from(
      [ThumbnailerFilter.new,
       CommandFilterTerminus.new(ConvertCommand.new)]
    )

  end
end
