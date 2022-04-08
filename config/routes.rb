# frozen_string_literal: true

Rails.application.routes.draw do
  root "tops#show"
  resources :items
  resources :tops
end
