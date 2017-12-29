module Sandboxy
    class Middleware

        def initialize app
            @app = app
        end

        def call env
            require 'sandboxy'

            previous_environment = Sandboxy.environment
            $sandboxy = nil

            puts "Sandboxy: Moved to #{Sandboxy.configuration.default} environment" if Sandboxy.environment != previous_environment
        end

    end
end
