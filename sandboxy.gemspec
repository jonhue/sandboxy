# -*- encoding: utf-8 -*-
require File.expand_path(File.join('..', 'lib', 'sandboxy', 'version'), __FILE__)

Gem::Specification.new do |gem|
    gem.name                  = 'sandboxy'
    gem.version               = Sandboxy::VERSION
    gem.platform              = Gem::Platform::RUBY
    gem.summary               = 'Add a Sandbox to your Rails app'
    gem.description           = 'Sandboxy adds a layer to specified ActiveRecord models to use live & sandbox data in the same environment & database.'
    gem.authors               = 'Slooob'
    gem.email                 = 'developer@slooob.com'
    gem.homepage              = 'https://developer.slooob.com/open-source'
    gem.license               = 'MIT'

    gem.files                 = `git ls-files`.split("\n")
    gem.require_paths         = ['lib']

    gem.post_install_message  = IO.read('INSTALL.md')

    gem.required_ruby_version = '>= 2.3'

    gem.add_dependency 'rails', '>= 4.0'
end
