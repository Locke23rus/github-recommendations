GithubRecommendation::Application.routes.draw do

  root to: 'pages#welcome'

  match '/auth/github/callback' => 'sessions#create'
  delete '/sign_out' => 'sessions#destroy'

  mount Sidekiq::Web, at: '/sidekiq'

  get "/:id" => "users#show", :as => :user
end
