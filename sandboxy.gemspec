# frozen_string_literal: true

require File.expand_path(
  File.join('..', 'lib', 'sandboxy', 'version'),
  __FILE__
)

Gem::Specification.new do |gem|
  gem.name                  = 'sandboxy'
  gem.version               = Sandboxy::VERSION
  gem.platform              = Gem::Platform::RUBY
  gem.summary               = 'Virtual data-oriented environments for Rails'
  gem.description           = 'Sandboxy allows you to use virtual'\
                              'data-oriented environments inside a Rails'\
                              'application while being able to switch in'\
                              'between at runtime. It achieves that by using a'\
                              'combination of Rack Middleware and ActiveRecord.'
  gem.authors               = 'Jonas Hübotter'
  gem.email                 = 'me@jonhue.me'
  gem.homepage              = 'https://github.com/jonhue/sandboxy'
  gem.license               = 'MIT'

  gem.files                 = Dir['README.md', 'LICENSE', 'lib/**/*',
                                  'app/**/*']
  gem.require_paths         = ['lib']

  gem.required_ruby_version = '>= 2.2.2'

  gem.add_dependency 'rails', '>= 5.0'

  gem.add_development_dependency 'factory_bot'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'shoulda'
  gem.add_development_dependency 'sqlite3'
end
