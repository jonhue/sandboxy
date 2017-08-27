class SandboxController < ApplicationController
    def edit
        session[:sandbox] == !session[:sandbox]
        redirect_to root_url
    end
end
