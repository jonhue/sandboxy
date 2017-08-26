require 'rails'

module Sandboxy
    class Railtie < Rails::Railtie

        initializer 'sandboxy.active_record' do
            ActiveSupport.on_load :active_record do
                include Sandboxy::Sandboxed
            end
        end

    end
end
