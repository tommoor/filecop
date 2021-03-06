# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filecop/version'

Gem::Specification.new do |spec|
  spec.name          = "filecop"
  spec.version       = Filecop::VERSION
  spec.authors       = ["Tom Moor"]
  spec.email         = ["tom.moor@gmail.com"]

  spec.summary       = %q{Checks filenames against a library of rules to find sensitive files}
  spec.homepage      = "https://github.com/tommoor/filecop"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
