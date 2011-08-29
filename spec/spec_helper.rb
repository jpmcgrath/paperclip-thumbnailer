require 'rspec'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

SUPPORT_DIRS = [
  File.join(PROJECT_ROOT, 'spec', 'support','*'),
  File.join(PROJECT_ROOT, 'lib', 'paperclip-thumbnailer', 'specs', '*')
]

SUPPORT_DIRS.each do |support_dir|
  Dir[support_dir].each do |support_file|
    require support_file
  end
end
