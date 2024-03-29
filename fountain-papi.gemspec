# frozen_string_literal: true

require_relative "lib/fountain/papi/version"

Gem::Specification.new do |spec|
  spec.name = "fountain-papi"
  spec.version = Fountain::Papi::VERSION
  spec.authors = ["Joey Cody"]
  spec.email = ["joeydcody@gmail.com"]

  spec.summary = "Ruby client for interfacing with Fountain Partners API."
  spec.description = "Fountain's Partner API for integrations. See more details: https://partners.fountain.com"
  spec.homepage = "https://github.com/onboardiq/fountain-papi"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/onboardiq/fountain-papi"
  spec.metadata["changelog_uri"] = "https://github.com/onboardiq/fountain-papi/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "dry-struct", "~> 1.4"
  spec.add_dependency "httparty", ">= 0.20", "< 0.22"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
end
