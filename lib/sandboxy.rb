require 'sandboxy/version'

module Sandboxy

    require 'sandboxy/configuration'

    require 'sandboxy/engine'

    autoload :Sandboxed, 'sandboxy/sandboxed'

    require 'sandboxy/middleware'
    require 'sandboxy/railtie'

end
