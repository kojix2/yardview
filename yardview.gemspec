# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yardview/version'

Gem::Specification.new do |spec|
  spec.name          = 'yardview_gtk3'
  spec.version       = YardView::VERSION
  spec.authors       = ['kojix2']
  spec.email         = ['2xijok@gmail.com']

  spec.summary       = 'GUI Yard document viewer'
  spec.description   = 'Simple GUI application to show the yard documents of installed Gems.'
  spec.homepage      = 'https://github.com/kojix2/yardview'
  spec.license       = 'MIT'

  spec.files         = Dir['exe/yardview', 'lib/**/*.rb', 'resources/**/*', '*.{md,txt}']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'gtk3'
  spec.add_dependency 'rack', '<3'
  spec.add_dependency 'webkit2-gtk'
  spec.add_dependency 'webrick', '1.7.0'
  spec.add_dependency 'yard', '0.9.28'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
