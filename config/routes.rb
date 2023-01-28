Rails.application.routes.draw do
  root "groups#index"
  
  resources :groups,  shallow: true do
    resources :messages
  end
end
