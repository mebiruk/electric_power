class EnergyMeterController < ApplicationController

    def all
        @energyMeter = EnergyMeter.limit(100)
        render json:@energyMeter, status: 200
    end

    def find_user_energy_hour
        @em = Array.new
        @time = Date.strptime(params[:date],'%Y/%m/%d')
        for a in 0..23 do  
            @energyMeter = EnergyMeter.where(["EXTRACT(HOUR FROM time) BETWEEN ? AND ?", a, a]).limit(288)
            @sg = @energyMeter.where("DATE(date) = ?", @time)
            @msg = @sg.where("user_id = #{params[:user_id]}")
            @power = @msg.sum(:power)
            @power_avg = @power
            @power_factor = @msg.sum(:power_factor)
            @power_factor_avg = @power_factor 
            @user_id = @msg.select(:user_id)
            @date = @msg.select(:date)
            @em << MyClass.new(@power_avg,@power_factor_avg,@time,a,params[:user_id])
        end
        render json: @em
    end

    def find_high_consumption_hour
        @time = Date.strptime(params[:date],'%Y/%m/%d')
        @energyMeter = EnergyMeter.where(["EXTRACT(HOUR FROM time) BETWEEN ? AND ?", 0, 23]).limit(288).order(power: :desc)
        @sg = @energyMeter.where("DATE(date) = ?", @time)
        @msg = @sg.where("user_id = #{params[:user_id]}")
        render json: @msg
    end

    def high_consumption_hour
        @time = Date.strptime(params[:date],'%Y/%m/%d')
        @energyMeter = EnergyMeter.where(["EXTRACT(HOUR FROM time) BETWEEN ? AND ?", 0, 23]).limit(288).order(power: :desc)
        @sg = @energyMeter.where("DATE(date) = ?", @time)
        @msg = @sg.where("user_id = #{params[:user_id]}").first
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

    # def find_user_energy_minute
    #     @time = Time.strptime(params[:time],'%H')
    #     @date = Date.strptime(params[:date],'%Y/%m/%d')
    #     t = @time.strftime('%H')
    #     @energyMeter = EnergyMeter.where(["EXTRACT(HOUR FROM time) BETWEEN ? AND ?", t, t]).limit(288)
    #     @sg = @energyMeter.where("DATE(date) = ?", @date)
    #     @msg = @sg.where("user_id = #{params[:user_id]}")
    #     render json: @msg
    # end

    def find_user_energy_week
        @start_date = Date.strptime(params[:date],'%Y/%m/%d')
        @end_date = DateTime.strptime(params[:date],'%Y/%m/%d') - 6.days
        @em = Array.new
        @order = Array.new
        for a in 0..6 do  
            @order << @end_date + a
            @energyMeter = EnergyMeter.where("DATE(date) <= ?",@order[a])
            @msg = @energyMeter.where("user_id = #{params[:user_id]}")
            @power = @msg.sum(:power)
            @power_avg = @power/ 7
            @power_factor = @msg.sum(:power_factor)
            @power_factor_avg = @power_factor / 7
            @user_id = @msg.select(:user_id)
            @date = @msg.select(:date)
            @em << MyClass.new(@power_avg,@power_factor_avg,@order[a],a,params[:user_id])            
        end
        render json: @em
    end

    # def find_user_energy_week
    #     @start_date = Date.strptime(params[:date],'%Y/%m/%d')
    #     @end_date = DateTime.strptime(params[:date],'%Y/%m/%d') - 7.days
    #     @energyMeter = EnergyMeter.where("DATE(date) <= ?",@start_date)
    #     @energyMeter = @energyMeter.where("DATE(date) > ?",@end_date)
    #     @msg = @energyMeter.where("user_id = #{params[:user_id]}")
    #     render json: @msg
    # end


    def find_user_energy_month
        @start_date = Date.strptime(params[:date],'%Y/%m/%d')
        @end_date = DateTime.strptime(params[:date],'%Y/%m/%d') - 30.days
        @em = Array.new
        @order = Array.new
        # @energyMeter = EnergyMeter.where("DATE(date) <= ?",@start_date)
        # @energyMeter = @energyMeter.where("DATE(date) > ?",@end_date)
        # @msg = @energyMeter.where("user_id = #{params[:user_id]}")
        for a in 0..29 do  
            @order << @end_date + a
            # @energyMeter = EnergyMeter.where("DATE(date) <= ?",@order[a])
            @energyMeter = EnergyMeter.where("DATE(date) <= ?",@order[a])
            # @energyMeter = @energyMeter.where("DATE(date) > ?",@end_date)
            @msg = @energyMeter.where("user_id = #{params[:user_id]}")
            @power = @msg.sum(:power)
            @power_avg = @power/ 7
            @power_factor = @msg.sum(:power_factor)
            @power_factor_avg = @power_factor / 7
            @user_id = @msg.select(:user_id)
            @date = @msg.select(:date)
            @em << MyClass.new(@power_avg,@power_factor_avg,@order[a],a,params[:user_id])            
        end
        render json: @em
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

class MyClass 
    attr_accessor :power, :power_factor,:date,:time,:user_id
    def initialize(power, power_factor,date,time,user_id)
      @power = power
      @power_factor = power_factor
      @date = date
      @time = time
      @user_id = user_id
    end
end
  