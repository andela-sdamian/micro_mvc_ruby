TodoApplication.routes.draw do
  root 'task#index'
  get '/tasks', to: 'task#index'
  get '/task/new', to: 'task#new'
  post '/task/:id', to: 'task#create'
  get '/task/:id/edit', to: 'task#edit'
  put '/task/:id', to: 'task#update'
  get '/task/:id', to: 'task#show'
  patch '/task/:id', to: 'task#update'
  delete '/task/:id', to: 'task#destroy'
end
