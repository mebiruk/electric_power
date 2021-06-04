class AuthenticationUserController < ApplicationController
       
    def authenticate
        command = AuthenticateUser.call(params[:username], params[:password])
       
          if command.success?
            command.result
          else
            command.errors
          end
        end
    
        def login
          customer = User.find_by_username(params[:username])
          if customer && customer.authenticate(params[:password_digest])
            render json: {user:authenticate, customer_type: customer.role_type_id, customer_id:customer.id }
          else
            render json:  authenticate , status: :unauthorized
          end
        end

end
