module Sandboxy

    class << self
        attr_accessor :configuration

        def environment
            $sandboxy ||= Sandboxy.configuration.default
            $sandboxy
        end

        def environment= value
            $sandboxy = value
        end

        def method_missing m, *args
            if m.to_s[/(.+)_environment?/]
                self.environment? $1
            else
                super
            end
        end

        def respond_to? m, include_private = false
            super || m.to_s[/(.+)_environment?/]
        end

        def environment? value
            self.environment == value
        end
    end

    def self.configure
        self.configuration ||= Configuration.new
        yield configuration
    end

    class Configuration

        attr_accessor :default
        attr_accessor :retain

        def initialize
            @default = 'live'
            @retain = false
        end

    end
end
