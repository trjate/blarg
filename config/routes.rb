Rails.application.routes.draw do

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  root to: 'posts#index'

  get 'tags/:name', to: 'tags#show', as: 'tagged_posts'

  resources :posts do
    # post 'comments', to: 'comments#create'
    resources :comments, only: [:create]
  end
end

  # resources :tags, only: [:show]
  # only knows about: :show, :create, :update, :delete, :index, :edit, :n
  # get 'post/:id', to: 'posts#show', as: 'post'
  # get 'post/:id/edit', to: 'posts#edit', as: 'post_edit'
  # pat 'post/:id', to: 'posts#update'
  # deete 'post/:id', to: 'posts#delete'
  # post 'post/:id/comments', to: 'comments#create', as: 'comments'

  # get 'posts/new', to: 'posts#new'
  # post 'posts', to: 'posts#create'
  # get 'posts', to: 'posts#index'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purc

  # Example resource route (maps HTTP verbs to controller actions autatically):
  #   esources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  # end
  #   end

  # Emple resource route with sub-resources:
  #   esources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #nd

  # Example resource route with concerns:
  #  oncern :toggleable do
  #    post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
