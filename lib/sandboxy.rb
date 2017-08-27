require 'sandboxy/version'


module Sandboxy

    autoload :Sandboxed, 'sandboxy/sandboxed'

    require 'sandboxy/configuration'
    require 'sandboxy/middleware'
    require 'sandboxy/railtie' # if defined?(Rails)

end
