module Sandboxy
    class Middleware

        def initialize app
            @app = app
        end

        def call env
            previous_sandbox = $sandbox
            $sandbox = Sandboxy.environment == 'sandbox' ? true : false
            puts 'Sandbox: Moved to ' + Sandboxy.environment + ' environment' if $sandbox != previous_sandbox
        end

    end
end
