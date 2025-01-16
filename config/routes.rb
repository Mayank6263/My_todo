Rails.application.routes.draw do
  root 'users#index'
  resources :tasks, only: [:index, :new, :create, :destroy, :edit, :update, :show] do
      patch :toggle_completed, on: :member
  end
  resources :sessions, only: [:index, :new, :create, :destroy]
  resources :users, only: [:index, :new,:create, :destroy]
  delete '/logout', to: 'sessions#destroy'
end
