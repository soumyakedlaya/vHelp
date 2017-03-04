Rails.application.routes.draw do
  root 'users#index'
  post '/donors' => 'donors#create' #reads create method in donors controller
  get '/donor/:id' => 'donors#show'

  post '/charityReps' => 'charity_reps#create'
  get '/charityRep/:id' => 'charity_reps#show'

  post '/:id/donations' => 'donors#donation'

  get '/login' => 'sessions#index'
  post '/login' => 'sessions#create'

  delete '/sessions' => 'sessions#destroy'
end
