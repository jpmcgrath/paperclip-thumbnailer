require 'paperclip-thumbnailer/processor'
require 'paperclip-thumbnailer/filters/thumbnailer_filter'
require 'paperclip-thumbnailer/filters/image_magick_filter'

module Paperclip
  module Thumbnailer

    Thumbnail = Processor.build_from([ThumbnailerFilter.new, ImageMagickFilter.new])

  end
end
