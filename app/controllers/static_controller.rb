class StaticController < ActionController::Base
    def home
        render json: {status: 200, message: "It's Working!"}
    end
end
