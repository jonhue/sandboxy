require 'sandboxy/version'

module Sandboxy

    autoload :Configuration, 'sandboxy/configuration'

    class << self
        attr_accessor :configuration
    end

    def self.configure
        self.configuration ||= Configuration.new
        yield configuration
    end

    autoload :Sandboxed, 'sandboxy/sandboxed'

    require 'sandboxy/middleware'
    require 'sandboxy/railtie'

end
