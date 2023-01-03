lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "scrapify/version"

Gem::Specification.new do |spec|
  spec.name          = "scrapify"
  spec.version       = Scrapify::VERSION
  spec.authors       = ["Clay Dunston"]
  spec.email         = ["dunstontc@gmail.com"]

  spec.summary       = "Models for Shopify"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/tcd/scrapify"
  spec.license       = "MIT"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage,
    "changelog_uri" => "https://github.com/tcd/scrapify/blob/master/changelog.md",
    "yard.run" => "yri", # use "yard" to build full HTML docs.
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0.2"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.12.2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "simplecov"

  spec.add_development_dependency "httparty", "~> 0.21.0"
  spec.add_development_dependency "nokogiri", "~> 1.10.4"
  spec.add_development_dependency "reverse_markdown", "~> 1.3.0"
end
