class DueBalanceController < ApplicationController
    def all
        @dueBalance = DueBalance.all
        render json:@dueBalance, status: 200
    end

    def find
        @dueBalance = DueBalance.find(params[:id])
        if @dueBalance
            render json: @dueBalance, status:200
        else
            render json: {error: 'unable to find dueBalance'}, status: 400
        end
    end

    def create
        @dueBalance = DueBalance.new(due_balance_params)
        if @dueBalance.save
            render json: @dueBalance, status: 200
        else
            render json: {error: 'unable to create dueBalance'}, status: 400
        end
    end

    def update
        @dueBalance = DueBalance.find(params[:id])
        if @dueBalance.update(due_balance_params)
            render json: @dueBalance, status: 200
        else
            render json: {error: 'unable to update dueBalance'}, status: 400
        end
    end

    def delete
        @dueBalance = DueBalance.find(params[:id])
        if @dueBalance
            @dueBalance.destroy
            render json: {success: 'dueBalance deleted successfully'}, status: 200
        else
            render json: {error: 'unable to delete dueBalance'}, status: 400
        end
    end

    def due_balance_params
        params.permit(:balance,:user_id)
    end
end
