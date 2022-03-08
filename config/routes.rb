Rails.application.routes.draw do
  
  # post 'follow/:user_id/:following_id', to: "follow#follow"

  devise_for :users

  devise_scope :user do
    post "sign_in", to: "sessions#create"
  end

  resources :follow do
    post :create, on: :collection
    delete :unfollow, on: :collection
  end  

  resources :users do
    get :profile, on: :collection
  end  

  # get 'users/profile'
  
  resources :tweets do
    post :create, on: :collection
    get :get_tweets, on: :collection
    get :get_tweet_owner, on: :collection
    get :followees_tweets, on: :collection
  end

  # post "tweet/:user_id/:tweet_text", to: "tweets#create"

  # get "tweets/:user_id", to: "tweets#get_tweets"

  # get "tweet_owner/:id", to: "tweets#get_tweet_owner"

  resources :phone_numbers do 
    post :create, on: :collection
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
# localhost:3000/follow/1/create  ==> without collection

# localhost:3000/follow/create/1 ==> with collection