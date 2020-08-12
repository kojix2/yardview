# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yardview/version'

Gem::Specification.new do |spec|
  spec.name          = 'yardview_gtk3'
  spec.version       = Yardview::VERSION
  spec.authors       = ['kojix2']
  spec.email         = ['2xijok@gmail.com']

  spec.summary       = 'GUI Yard document viewer'
  spec.description   = 'Simple GUI application to show the yard documents of installed Gems.'
  spec.homepage      = 'https://github.com/kojix2/yardview'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'atk'
  spec.add_dependency 'cairo'
  spec.add_dependency 'cairo-gobject'
  spec.add_dependency 'gdk3'
  spec.add_dependency 'gdk_pixbuf2'
  spec.add_dependency 'gio2'
  spec.add_dependency 'glib2'
  spec.add_dependency 'pango'
  spec.add_dependency 'yard'

  spec.add_dependency 'gtk3'
  spec.add_dependency 'webkit2-gtk'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
