Rails.application.routes.draw do
  devise_for :users
  resources :articles do
    resources :comments, only: [:create, :destroy, :update, :show]
  end
=begin
    get "/articles"
    post "/articles"
    delete "/articles/:id"
    get "/articles/:id"
    get "/articles/new"
    get "articles/:id/edit"
    patch "articles/:id"
    put "articles/:id"
=end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
