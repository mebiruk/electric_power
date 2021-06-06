class EnergyMeterController < ApplicationController

    def all
        @energyMeter = EnergyMeter.limit(100)
        render json:@energyMeter, status: 200
    end

    def find_user_energy_hour
        @time = Date.strpdate(params[:date],'%Y/%m/%d')
        @energyMeter = EnergyMeter.where(["EXTRACT(HOUR FROM time) BETWEEN ? AND ?", 0, 23]).limit(288)
        @sg = @energyMeter.where("DATE(date) = ?", @time)
        @msg = @sg.where("user_id = #{params[:user_id]}")
        render json: @msg
    end

    def find_user_energy_minute
        @time = Time.strptime(params[:time],'%H')
        @date = Date.strptime(params[:date],'%Y/%m/%d')
        t = @time.strftime('%H')
        @energyMeter = EnergyMeter.where(["EXTRACT(HOUR FROM time) BETWEEN ? AND ?", t, t]).limit(288)
        @sg = @energyMeter.where("DATE(date) = ?", @date)
        @msg = @sg.where("user_id = #{params[:user_id]}")
        render json: @msg
    end

    def find_user_energy_week
        @start_date = Date.strptime(params[:date],'%Y/%m/%d')
        @end_date = DateTime.strptime(params[:date],'%Y/%m/%d') + 7
        @energyMeter = EnergyMeter.where("DATE(date) < ?",@end_date)
        @energyMeter = @energyMeter.where("DATE(date) >= ?",@start_date)
        @msg = @energyMeter.where("user_id = #{params[:user_id]}")
        render json: @msg
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
