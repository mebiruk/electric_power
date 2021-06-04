class RoleTypeController < ApplicationController

    def all
        @roleType = RoleType.all
        render json:@roleType, status: 200
    end

    def find
        @roleType = RoleType.find(params[:id])
        if @roleType
            render json: @roleType, status:200
        else
            render json: {error: 'unable to find roleType'}, status: 400
        end
    end

    def create
        @roleType = RoleType.new(role_type_params)
        if @roleType.save
            render json: @roleType, status: 200
        else
            render json: {error: 'unable to create roleType'}, status: 400
        end
    end

    def update
        @roleType = RoleType.find(params[:id])
        if @roleType.update(role_type_params)
            render json: @roleType, status: 200
        else
            render json: {error: 'unable to update roleType'}, status: 400
        end
    end

    def delete
        @roleType = RoleType.find(params[:id])
        if @roleType
            @roleType.destroy
            render json: {success: 'roleType deleted successfully'}, status: 200
        else
            render json: {error: 'unable to delete roleType'}, status: 400
        end
    end

    def role_type_params
        params.permit(:role)
    end

end
