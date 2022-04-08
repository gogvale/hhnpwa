# frozen_string_literal: true

Rails.application.routes.draw do
  root "tops#index"
  resources :items
  resources :tops
end
