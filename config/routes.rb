Rails.application.routes.draw do
	get "/issues/:number/events", to: "events#index", as: "events_issue"
	resources :events, only: [:create]
end
