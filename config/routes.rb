# frozen_string_literal: true

Rails.application.routes.draw do
  root "tops#index"
  resources :items do
    resources :comments
  end
  resources :tops
end
