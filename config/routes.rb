Rails.application.routes.draw do
  resources :tasks do
    delete '/remove_completed', action: :destroy_completed, on: :collection
    put '/update_all', action: :update_all, on: :collection
  end
end
