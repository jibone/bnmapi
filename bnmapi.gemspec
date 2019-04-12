
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bnmapi/version"

Gem::Specification.new do |spec|
  spec.name          = "BnmAPI"
  spec.version       = BnmAPI::VERSION
  spec.authors       = ["J Shamsul Bahri (jibone))"]
  spec.email         = ["jibone@gmail.com"]

  spec.summary       = %q{Wrapper around BNM open API}
  #spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/jibone/bnmapi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.executables   = `git ls-files -- bin/*`.split("\n").map do |f|
    File.basename(f)
  end

  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 1.17"
  spec.add_development_dependency 'rake', "~> 10.0"
  spec.add_development_dependency 'rspec', "~> 3.0"
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-console'
end
