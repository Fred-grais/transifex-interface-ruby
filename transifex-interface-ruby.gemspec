# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'transifex/version'

Gem::Specification.new do |spec|
  spec.name          = "transifex-interface-ruby"
  spec.version       = Transifex::VERSION
  spec.authors       = ["Fred-grais"]
  spec.email         = ["frederic.grais@gmail.com"]
  spec.description   = %q{A Transifex API interface written in Ruby}
  spec.summary       = %q{This gem allows you to communicate with the Transifex API to perform every possible actions listed in the documentation: http://docs.transifex.com/developer/api/}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency('rails', '~> 4.0.0')
  spec.add_development_dependency "webmock", ">= 2.1.0"
  spec.add_development_dependency "vcr", ">= 3.0.3"
  spec.add_development_dependency "pry"
end
