module Sandboxy
    class Middleware

        def initialize app
            @app = app
        end

        def call env
            require 'sandboxy'

            previous_sandbox = $sandbox
            $sandbox = Sandboxy.configuration.environment == 'sandbox'

            puts "Sandbox: Moved to #{Sandboxy.configuration.environment.to_s} environment" if $sandbox != previous_sandbox
        end

    end
end
