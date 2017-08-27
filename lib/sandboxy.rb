require 'sandboxy/version'


module ActsAsFavoritor

    autoload :Sandboxed, 'sandboxy/sandboxed'

    require 'sandboxy/railtie' # if defined?(Rails)

end
