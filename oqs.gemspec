# frozen_string_literal: true

require_relative "lib/oqs/version"

Gem::Specification.new do |spec|
  spec.name          = "liboqs"
  spec.version       = Oqs::VERSION
  spec.authors       = ["Chris Liaw"]
  spec.email         = ["chrisliaw@antrapol.com"]

  spec.summary       = "Ruby wrapper for Open Quantum Safe library"
  spec.description   = "Ruby wrapper for liboqs from Open Quantum Safe library. This version included platform binary of Linux, MacOS and Windows based on git commit b803b54179c1cea9091d9331cc8085fc235e1be4"
  spec.homepage      = "https://github.com/chrisliaw/liboqs-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/chrisliaw/liboqs-ruby.git"
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.files += Dir.glob(File.join(__dir__,"native","**/*oqs*"))
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'tlogger'

  spec.add_development_dependency "devops_helper"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
