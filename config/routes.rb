Rails.application.routes.draw do
	use_doorkeeper
  
  devise_for :users, controllers: {
        sessions: 'users/sessions'
  }
  get "me" => "application#me"

  get "test" => "home#send_current_user_to_client"
  
  root :to => 'home#index'
end