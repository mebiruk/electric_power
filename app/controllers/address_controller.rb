class AddressController < ApplicationController

    def all
        @address = Address.all
        render json:@address, status: 200
    end

    def find
        @address = Address.find(params[:id])
        if @address
            render json: @address, status:200
        else
            render json: {error: 'unable to find address'}, status: 400
        end
    end

    def create
        @address = Address.new(address_params)
        if @address.save
            render json: @address, status: 200
        else
            render json: {error: 'unable to create address'}, status: 400
        end
    end

    def update
        @address = Address.find(params[:id])
        if @address.update(address_params)
            render json: @address, status: 200
        else
            render json: {error: 'unable to update address'}, status: 400
        end
    end

    def delete
        @address = Address.find(params[:id])
        if @address
            @address.destroy
            render json: {success: 'address deleted successfully'}, status: 200
        else
            render json: {error: 'unable to delete address'}, status: 400
        end
    end

    def address_params
        params.permit(:region,:zone,:house_number,:woreda,:kebele,:block_number)
    end

end
