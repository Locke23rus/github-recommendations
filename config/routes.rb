GithubRecommendation::Application.routes.draw do

  root to: 'pages#welcome'

  match '/auth/github/callback' => 'sessions#create'
  delete '/sign_out' => 'sessions#destroy'

  # Recommendations
  put '/recommendations/:id/skip' => 'recommendations#skip', :as => 'skip_recommendation'
  get '/:user_id/recommendations' => 'recommendations#index', :as => 'user_recommendations'

  mount Sidekiq::Web, at: '/sidekiq'

  get "/:id" => "users#show", :as => :user
end
