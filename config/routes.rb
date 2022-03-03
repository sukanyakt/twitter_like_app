Rails.application.routes.draw do
  
  devise_for :users

  devise_scope :user do
    post "sign_in", to: "sessions#create"
    delete "sign_out", to: "sessions#logout"
  end

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
