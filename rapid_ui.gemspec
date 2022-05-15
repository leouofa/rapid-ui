# frozen_string_literal: true

require_relative "lib/rapid_ui/version"

Gem::Specification.new do |spec|
  spec.name = "rapid_ui"
  spec.version = RapidUi::VERSION
  spec.authors = ["Leonid Medovyy"]
  spec.email = ["leonid@storypro.io"]

  spec.summary = "Ruby on Rails UI development framework based on ViewComponent"
  spec.homepage = "https://github.com/realstorypro/rapid-ui"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/realstorypro/rapid-ui/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "view_component"
  spec.add_dependency "hashie"
  spec.add_dependency 'byebug'

  # Uncomment to register a new dependency of your gem

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
