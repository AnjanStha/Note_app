Rails.application.routes.draw do
  get 'note/index'
  devise_for :users
  # root path
  #root "home#index"
  devise_scope :user do
    root  'devise/sessions#new'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/note', to: 'note#index', as: :note
  get '/note/new', to: 'note#new', as: :new_note
  post '/note/new', to: 'note#create', as: :note_create
  get '/note/edit', to: 'note#edit', as: :note_edit
  patch 'note/update', to: 'note#update', as: :note_update
  get '/note/show', to: 'note#show', as: :note_show

  delete "note_delete", to: "note#destroy"

  # Defines the root path route ("/")
  # root "articles#index"
end
