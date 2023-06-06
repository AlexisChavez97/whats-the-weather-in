# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "weather_reports#index"

  resources :weather_reports, only: %i[index new create]
end
