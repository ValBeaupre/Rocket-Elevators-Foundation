Rails.application.routes.draw do

  # resources :comments
  devise_for :users, :controllers => { registrations: 'registrations' }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  get '/residential' => 'home#residential'
  get '/commercial' => 'home#commercial'
  get '/quote' => 'quote#quote'
 # get '/interventions' => 'interventions#interventions'
  get '/index_rocket_elevators.html' => 'home#index'
  get '/rocket_elevators_residential.html' => 'home#residential'
  get '/rocket_elevators_commercial.html' => 'home#commercial'
  get '/quote.html' => 'quote#quote'
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

=begin 
Rails.application.routes.draw do
 devise_for :users
 mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

 authenticate :user do
   mount Blazer::Engine, at: "blazer"
   get 'pages/intervention'
   post '/new_intervention' => 'interventions#new_intervention'
end 
=end