class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def store_sandbox_environment
        session[:sandbox] == $sandbox unless session.has_key?(:sandbox)
    end
end
