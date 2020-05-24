Rails.application.routes.draw do
	get "/issues/:number/events", to: "events#index"
	resources :events, only: [:create]
end
