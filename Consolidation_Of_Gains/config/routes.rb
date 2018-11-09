Rails.application.routes.draw do

  # resources :comments
  devise_for :users, :controllers => { registrations: 'registrations' }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  get '/residential' => 'home#residential'
  get '/commercial' => 'home#commercial'
  get '/quote' => 'quote#quote'
 # get '/index-Interventions' => 'interventions#interventions'
  get '/index-RocketElevators.html' => 'home#index'
  get '/index-rocketElevators-residential.html' => 'home#residential'
  get '/index-rocketElevators-commercial.html' => 'home#commercial'
  get '/index-Quote.html' => 'quote#quote'
  post '/new_quote' => 'quote#new_quote'
  post '/new_lead' => 'lead#new_lead'
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