Rails.application.routes.draw do
 

  get 'post/:id', to: 'posts#show', as: 'post'
  
  get 'post/:id/edit', to: 'posts#edit', as: 'edit_post'

  get 'posts', to: 'posts#index'
  get 'posts/new', to: 'posts#new'
  post 'posts', to: 'posts#create'

 
end
