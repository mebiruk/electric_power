class UserController < ApplicationController
    def all
        @user = User.all
        render json:@user, status: 200
    end

    def find
        @user = User.find(params[:id])
        if @user
            render json: @user, status:200
        else
            render json: {error: 'unable to find user'}, status: 400
        end
    end

    def create
        hashed_password = BCrypt::Password.create(params[:password_digest])
        @user = User.new(user_params)
        @user.password_digest=hashed_password
        if @user.save
            render json: @user, status: 200
        else
            render json: {error: 'unable to create user'}, status: 400
        end
    end

    def login
        @user = User.find_by(username: params[:username])

    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            render json: @user, status: 200
        else
            render json: {error: 'unable to update user'}, status: 400
        end
    end

    def delete
        @user = User.find(params[:id])
        if @user
            @user.destroy
            render json: {success: 'user deleted successfully'}, status: 200
        else
            render json: {error: 'unable to delete user'}, status: 400
        end
    end

    def user_params
        params.permit(:name,:username,:password_digest,:email,:phone_number,:role_type_id,:connection_date,:address_id)
    end
    
end
