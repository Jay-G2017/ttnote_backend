Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 registrations: 'registrations',
                 sessions: 'sessions',
                 confirmations: 'confirmations'
             },
             path_names: {sign_in: 'login', sign_out: 'logout'},
             defaults: {format: :json}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index', defaults: {format: :json}
end
