module Books
    class API < Grape::API

        version 'v1', using: :path, vendor: 'books'
        format :json

        helpers do
            def authenticate! access_token
                if current_app ||= ::Application.find_by(access_token: access_token)
                    $sandbox = false
                elsif current_app ||= ::Application.find_by(sandbox_access_token: access_token)
                    $sandbox = true
                else
                    error!
                end
            end
        end

        rescue_from :all

        resource :books do
            params do
                requires :access_token, String
            end

            get :index do
                authenticate! params[:access_token]
                ::Book.all.limit(5)
            end
        end

    end
end
