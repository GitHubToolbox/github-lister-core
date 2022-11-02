lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'github-lister-core/version'

Gem::Specification.new do |spec|
    spec.name          = 'github-lister-core'
    spec.version       = GithubListerCore::VERSION
    spec.authors       = ['Tim Gurney aka Wolf']
    spec.email         = ['wolf@tgwolf.com']

    spec.summary       = 'Provide a simple, fast and, clean way to extract repository information from GitHub.'
    spec.description   = 'The aim of the gem is to provide a simple, fast and, clean way to extra repository information from GitHub. It comes with a number of methods but it is intentionally limited to repository based information.'
    spec.homepage      = 'https://github.com/DevelopersToolbox/github-lister-core'
    spec.license       = 'MIT'

    spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

    spec.metadata['rubygems_mfa_required'] = 'true'
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/DevelopersToolbox/github-lister-core'
    spec.metadata['changelog_uri'] = 'https://github.com/DevelopersToolbox/github-lister-core/blob/master/CHANGELOG.md'

    # Specify which files should be added to the gem when it is released.
    # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
    # rubocop:disable Layout/ExtraSpacing, Layout/SpaceAroundOperators
    spec.files         = Dir.chdir(File.expand_path(__dir__)) do
        `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    end
    # rubocop:enable Layout/ExtraSpacing, Layout/SpaceAroundOperators

    spec.bindir        = 'exe'
    spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ['lib']

    spec.add_development_dependency 'bundler', '~> 2'
    spec.add_development_dependency 'octokit', '~> 5'
    spec.add_development_dependency 'parallel', '~> 1.2'
    spec.add_development_dependency 'rake', '~> 13'
    spec.add_development_dependency 'reek', '~> 6'
    spec.add_development_dependency 'rspec', '~> 3.0'
    spec.add_development_dependency 'rubocop', '~> 1.38.0'

    spec.add_runtime_dependency 'octokit', '~> 5'
    spec.add_runtime_dependency 'parallel', '~> 1.2'
end
