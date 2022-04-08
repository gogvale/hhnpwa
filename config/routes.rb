# frozen_string_literal: true

Rails.application.routes.draw do
  get "/top", to: "tops#show"
  resources :items
end
