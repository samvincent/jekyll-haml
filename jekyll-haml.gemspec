# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-haml/version'

Gem::Specification.new do |gem|
  gem.name          = "jekyll-haml"
  gem.version       = Jekyll::Haml::VERSION
  gem.authors       = ["Sam Vincent"]
  gem.email         = ["sam.vincent@mac.com"]
  gem.description   = %q{HAML html converter for Jekyll}
  gem.summary       = %q{Convert HAML files to standard HTML files as part of your Jekyll build.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'jekyll', ">= 0.10.0"
  gem.add_runtime_dependency 'haml',   ">= 3.0.0"
end
