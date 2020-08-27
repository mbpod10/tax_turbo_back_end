class RegistrationsController < ApplicationController
 
    def create

        if params['user']['password'] != params['user']['password_confirmation']
            render json: {
                status: "Passwords Dont Match"
            }
         elsif User.where(email: params['user']['email']).first
            render json: {
                status: "Email Matches Current User"
            }
        elsif params['user']['password'].length < 6
            render json: {
                status: "Password Must Contain More Than 6 Characters"
            }
        else user = User.create!(
                email: params['user']['email'],
                password: params['user']['password'],
                password_confirmation: params['user']['password_confirmation']
            )   
            if user
                session[:user_id] = user.id
                render json: {
                    status: :created, 
                    user: user
            }
            else            
                render json: {status: 500, text: "not working"}
            end
        end
    end
end