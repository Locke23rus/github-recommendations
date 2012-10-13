GithubRecommendation::Application.routes.draw do

  root :to => 'pages#welcome'

  match '/auth/github/callback' => 'sessions#create'
  delete '/sign_out' => 'sessions#destroy'

end
