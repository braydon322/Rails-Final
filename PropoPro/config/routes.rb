Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :proposals
  root to: "pages#index"

  get '/creative', to: 'pages#creative'
  get '/company', to: 'pages#company'
  get '/cmpny', to: 'pages#companydash'
  get '/crtv', to: 'pages#creativedash'
  get '/proposals/:id/sign', to: 'proposals#sign', as: "sign"
  get '/crtv/price_up', to: 'proposals#price_up', as: "up"
  get '/crtv/price_down', to: 'proposals#price_down', as: "down"
  get '/crtv/signed', to: 'proposals#signed', as: "signed"
  get '/crtv/not_signed', to: 'proposals#unsigned', as: "unsigned"
  get '/crtv/date_up', to: 'proposals#date_up', as: "date_up"
  get '/crtv/date_down', to: 'proposals#date_down', as: "date_down"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
