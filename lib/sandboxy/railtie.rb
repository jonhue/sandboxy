require 'rails/railtie'
require 'active_record'


module Sandboxy
    class Railtie < Rails::Railtie

        initializer 'sandboxy.active_record' do
            ActiveSupport.on_load :active_record do
                include Sandboxy::Sandboxed
            end
        end

        initializer 'sandboxy.middleware' do |app|
            app.middleware.use(Sandboxy::Middleware) unless Sandboxy.configuration&.retain_environment
        end

        config.after_initialize do
            puts "Sandboxy: Using #{Sandboxy.configuration.environment} environment"
            $sandbox = Sandboxy.configuration.environment == 'sandbox'
        end

    end
end
