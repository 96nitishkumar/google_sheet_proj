Rails.application.routes.draw do
  
  namespace :user_block do 
    resources :users
  end

  namespace :google_sheet_block do 
    post 'create_file', to: 'google_sheet#create_file'
    get 'country_details', to: 'google_sheet#country_details'
  end
end
