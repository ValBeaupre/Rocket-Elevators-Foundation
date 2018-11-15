Rails.application.routes.draw do

  # resources :comments
  devise_for :users, :controllers => { registrations: 'registrations' }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  get '/residential' => 'home#residential'
  get '/commercial' => 'home#commercial'
  get '/quote' => 'quote#quote'
  get '/index_RocketElevators.html' => 'home#index'
  get '/index-rocketElevators-residential.html' => 'home#residential'
  get '/index-rocketElevators-commercial.html' => 'home#commercial'
  get '/index-Quote.html' => 'quote#quote'
  post '/new_quote' => 'quote#new_quote'
  post '/new_lead' => 'lead#new_lead'
  post '/new_intervention' => 'interventions#new_intervention'
  post '/create_intervention' => 'interventions#create_intervention'
  post '/intervention_ticket' => 'interventions#intervention_ticket'
  get '/chart' => 'charts#chart'
  get '/google' => 'google#google'

  resources :interventions do
    get :get_buildings_for_client, on: :collection
    get :get_batteries_for_building, on: :collection
    get :get_columns_for_battery, on: :collection
    get :get_elevators_for_column, on: :collection
  end  
  

  root 'home#index'

end