# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "paperclip-thumbnailer/version"

Gem::Specification.new do |s|
  s.name        = "paperclip-thumbnailer"
  s.version     = Paperclip::Thumbnailer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["thoughtbot"]
  s.email       = ["support@thoughtbot.com"]
  s.homepage    = ""
  s.summary     = %q{The Paperclip thumbnailer as composable, modularized, easily-testable, and reusable pieces.}
  s.description = %q{
    This gem provides you with a base for creating a composable Paperclip
    processor, as well as a sample thumbnail filter and processor built atop of
    it.
  }

  s.rubyforge_project = "paperclip-thumbnailer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('paperclip', '~> 2.4')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
end
