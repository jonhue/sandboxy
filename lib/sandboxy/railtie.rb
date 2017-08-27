require 'rails'


module Sandboxy
    class Railtie < Rails::Railtie

        initializer 'sandboxy.active_record' do
            ActiveSupport.on_load :active_record do
                include Sandboxy::Sandboxed
            end
        end

        initializer 'sandboxy.configure_rails_initialization' do |app|
            require 'sandboxy'
            puts 'Sandboxy: Using ' + Sandboxy.environment.to_s + ' environment'

            $sandbox = Sandboxy.environment == 'sandbox' ? true : false
            app.middleware.use(Sandboxy::Middleware) unless Sandboxy.retain_environment
        end

    end
end
