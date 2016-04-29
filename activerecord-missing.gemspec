# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_record/missing/version"

Gem::Specification.new do |spec|
  spec.name          = "activerecord-missing"
  spec.version       = ActiveRecord::Missing::VERSION
  spec.authors       = ["Eugene Surzhko"]
  spec.email         = ["surzhkoyevhen@gmail.com"]

  spec.summary       = %q{Allows easily find and support missing foreign keys (, unique and some other validations).}
  spec.description   = <<-EOS
    Allows easily find and support missing foreign keys (, unique and some other validations).
  EOS
  spec.homepage      = "https://github.com/Surzhko/activerecord-missing"
  spec.license       = "MIT"

  spec.test_files    = Dir[ "spec/*_spec.rb" ]
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
