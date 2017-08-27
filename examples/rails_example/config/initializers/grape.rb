Rails.application.config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
Rails.application.config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
