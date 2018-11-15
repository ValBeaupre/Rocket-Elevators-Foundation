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
        puts params[:intervention]
        puts params[:intervention][:column_id]
        puts params[:intervention]["column_id"]
        puts params["intervention"]["column_id"]
        params["intervention"].delete("column_id") if params["intervention"]["column_id"] == "Nil"
        params["intervention"].delete("elevator_id") if params["intervention"]["elevator_id"] == "Nil"
        attributes = params[:intervention].permit!
        puts params
        puts "^ params ^"
        #ajouter author_id dans le hash 'attributes' ici = current user de la session
        attributes[:author_id] = current_user.employee.id 
        puts attributes
        puts "^ attributes ^"
        intervention = Intervention.new(attributes)
        if !intervention.valid? 
            puts "*****************INVALIDE*************************"
            intervention.errors.each do |error|
                puts error      
            end
            puts "^ errors ^"
        else
            intervention.save
        end 

        intervention_ticket(intervention)
    end    

    def intervention_ticket(intervention)

        comment = { :value => "Intervention ticket author: #{intervention.author.first_name} #{intervention.author.last_name}
        \n \n Client: #{intervention.customer.business_name} 
        \n \n Building #: #{intervention.building.id}   (#{intervention.building.building_name})
        \n \n Battery #: #{intervention.battery.id} 
        \n \n Column #: #{intervention.column ? intervention.column.id : "N/Ap"} 
        \n \n Elevator shaft #: #{intervention.elevator ? intervention.elevator.id : "N/Ap"} 
        \n \n Intervention assigned to: #{intervention.employee ? intervention.employee.first_name : "None"} #{intervention.employee ? intervention.employee.last_name : ""} 
        \n \n Intervention description: \n #{intervention.report} "}

        ticket = ZendeskAPI::Ticket.new($client, :type => "support", :priority => "urgent",
        :subject => "Intervention ticket for the #{intervention.customer.business_name} building",
        :comment => comment
        )

        ticket.save!
    end

end