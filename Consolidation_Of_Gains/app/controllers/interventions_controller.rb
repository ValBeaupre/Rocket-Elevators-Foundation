class InterventionsController < ApplicationController

    def new
        puts "NEW"
        @clients = Customer.all
        puts @clients.collect{ |c| c.contact_full_name }

        @employee = Employee.all
        puts @employee.collect{ |e| e.first_name + e.last_name }
    end

    def get_buildings_for_client
        puts "get_buildings_for_client"
        puts params
        id_client = params[:client_id]
        @buildings = Building.where(customer_id: id_client)
        puts @buildings
        render json: @buildings
    end    
    
    def get_batteries_for_building
        puts "get_batteries_for_building"
        puts params
        id_building = params[:building_id]
        @batteries = Battery.where(building_id: id_building)
        puts @batteries
        render json: @batteries
    end

    def get_columns_for_battery
        puts "get_columns_for_battery"
        puts "battery - test"
        puts params
        @columns = Column.where(battery_id: params[:battery_id])
        puts @columns
        render json: @columns
    end

    def get_elevators_for_column
        puts "get_elevators_for_column"
        puts params
        @elevators = Elevator.where(column_id: params[:column_id])
        puts @elevators
        render json: @elevators
    end 


    def create
        # puts "CREATE"
    end

end
