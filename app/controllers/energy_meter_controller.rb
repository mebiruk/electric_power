class EnergyMeterController < ApplicationController

    def all
        @energyMeter = EnergyMeter.all
        render json:@energyMeter, status: 200
    end

    def find
        @energyMeter = EnergyMeter.find(params[:id])
        if @energyMeter
            render json: @energyMeter, status:200
        else
            render json: {error: 'unable to find energyMeter'}, status: 400
        end
    end

    def create
        @energyMeter = EnergyMeter.new(energy_meter_params)
        if @energyMeter.save
            render json: @energyMeter, status: 200
        else
            render json: {error: 'unable to create energyMeter'}, status: 400
        end
    end

    def update
        @energyMeter = EnergyMeter.find(params[:id])
        if @energyMeter.update(energy_meter_params)
            render json: @energyMeter, status: 200
        else
            render json: {error: 'unable to update energyMeter'}, status: 400
        end
    end

    def delete
        @energyMeter = EnergyMeter.find(params[:id])
        if @energyMeter
            @energyMeter.destroy
            render json: {success: 'energyMeter deleted successfully'}, status: 200
        else
            render json: {error: 'unable to delete energyMeter'}, status: 400
        end
    end

    def energy_meter_params
        params.permit(:power,:power_factor,:date,:time,:user_id)
    end
end
