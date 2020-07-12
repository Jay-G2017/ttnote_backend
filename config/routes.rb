Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               registrations: 'registrations',
               sessions: 'sessions',
               confirmations: 'confirmations'
             },
             path_names: { sign_in: 'login', sign_out: 'logout' },
             defaults: { format: :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index', defaults: { format: :json }
  get '/try_authenticate', to: 'welcome#try_authenticate', defaults: { format: :json }

  resources :categories, only: %i[index show update create destroy], defaults: { format: :json } do
    resources :projects, only: %i[index create]
  end

  get '/projects', to: 'projects#all', default: { format: :json }
  resources :projects, only: %i[show update destroy], defaults: { format: :json } do
    resources :titles, only: [:create] do
      resources :todos, only: [:create]
    end
  end

  resources :titles, only: %i[update destroy]
  resources :todos, only: %i[update destroy] do
    patch 'tag_today_todo', on: :member
    resources :tomatoes, only: :create
  end

  resources :tomatoes, only: %i[update destroy]

  resources :today_tomatoes, only: [:index]

  resources :daily_notes, only: %i[update index]

  patch '/user_settings', to: 'user_settings#update', default: { format: :json }
  get '/today_tomato_count', to: 'tomatoes#today_tomato_count', default: { format: :json }
end
