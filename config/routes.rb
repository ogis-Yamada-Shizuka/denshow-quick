Rails.application.routes.draw do
  resources :sections
  resources :models
  resources :vendors
  root 'request_applications#index'
  resources :request_applications

  get 'request_applications/:id/regist_memo' => 'request_applications#regist_memo', as: :regist_memo
  get 'request_applications/:id/regist' => 'request_applications#regist', as: :regist_progress
  patch 'request_applications/:id/regist' => 'request_applications#regist', as: :regist_confirm

  get 'request_applications/:id/reject_memo' => 'request_applications#reject_memo', as: :reject_memo
  get 'request_applications/:id/reject' => 'request_applications#reject', as: :reject_progress
  patch 'request_applications/:id/reject' => 'request_applications#reject', as: :reject_confirm

  get 'request_applications/:id/interrupt_memo' => 'request_applications#interrupt_memo', as: :interrupt_memo
  get 'request_applications/:id/interrupt' => 'request_applications#interrupt', as: :interrupt_progress
  patch 'request_applications/:id/interrupt' => 'request_applications#interrupt', as: :interrupt_confirm

  get 'request_applications/:id/revert_memo' => 'request_applications#first_to_revert_memo', as: :revert_memo
  get 'request_applications/:id/revert' => 'request_applications#first_to_revert', as: :revert_progress
  patch 'request_applications/:id/revert' => 'request_applications#first_to_revert', as: :revert_confirm


  post 'vendors/get_name' => 'vendors#get_name'

  resources :progresses
  resources :flows
  resources :flow_orders
  resources :depts
  resources :users



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
