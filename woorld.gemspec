# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'woorld/version'

Gem::Specification.new do |spec|
  spec.name          = 'woorld'
  spec.version       = Woorld::VERSION
  spec.authors       = ['Michael Avila']
  spec.email         = ['me@michaelavila.com']
  spec.description   = 'A simple text-based adventure game'
  spec.summary       = 'A simple text-based adventure game'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
