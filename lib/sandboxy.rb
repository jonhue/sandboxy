require 'sandboxy/version'

module Sandboxy

    require 'sandboxy/configuration'

    autoload :Sandboxed, 'sandboxy/sandboxed'

    require 'sandboxy/middleware'
    require 'sandboxy/railtie'

end
