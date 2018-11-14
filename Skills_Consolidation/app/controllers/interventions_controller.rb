class InterventionsController < ApplicationController
    before_action :authenticate_user!

    def new
        puts "NEW"
        @clients = Customer.order(:business_name)
        puts @clients.collect{ |c| c.business_name }

        @employee = Employee.order(:last_name)
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


    def create_intervention
        puts "CREATE Intervention"
        attributes = params[:intervention].permit!
        puts params
        puts "^ params ^"
        #ajouter author_id dans le hash 'attributes' ici = current user de la session
        attributes[:author_id] = current_user.id
        puts attributes
        puts "^ attributes ^"
        intervention = Intervention.create(attributes)
        if !intervention.valid? 
            puts intervention.errors
            puts "^ errors ^"
        end 

        intervention_ticket(intervention)
    end
    

    def intervention_ticket(intervention)

        comment = { :value => "Intervention ticket author: #{intervention.author} 
        \n \n Client: #{intervention.customer.business_name} 
        \n \n Building name: #{intervention.building.building_name} 
        \n \n Battery: #{intervention.battery.battery_id} 
        \n \n Column: #{intervention.column.column_id} 
        \n \n Elevator shaft: #{intervention.elevator.elevator_id} 
        \n \n Intervention assigned to: #{intervention.employee.first_name} #{intervention.employee.last_name} 
        \n \n Intervention description: #{intervention.report} "}

        # if intervention.column_id != nil
        #  !!   comment = "Column : #{intervention.column_id}"
        #     else
        #  !!   bat_message = "N/Ap"
        # end

        # if intervention.battery_id != nil
        #     bat_message = "Elevator : #{intervention.elevator_id}"
        #     else
        #     bat_message = "N/Ap"
        # end


        ticket = ZendeskAPI::Ticket.new($client, :type => "support", :priority => "urgent",
        :subject => "Intervention ticket for the #{intervention.customer.business_name} building",
        :comment => comment
        )

        ticket.save!
    end

end