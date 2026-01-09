# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "pages#home"

  # Products
  get "/products", to: "pages#products"
  get "/products/datasets", to: "pages#products_datasets"
  get "/products/api", to: "pages#products_api"
  get "/products/monitoring", to: "pages#products_monitoring"

  # Catalog
  get "/catalog", to: "catalog#index"
  get "/catalog/:slug", to: "catalog#show", as: :dataset

  # API docs
  get "/api", to: "pages#api_docs"

  # Solutions
  get "/solutions", to: "pages#solutions"

  # Quality & Compliance
  get "/quality", to: "pages#quality"
  get "/compliance", to: "pages#compliance"

  # Pricing
  get "/pricing", to: "pages#pricing"

  # Company
  get "/about", to: "pages#about"
  get "/careers", to: "pages#careers"
  get "/contact", to: "pages#contact"
  get "/privacy", to: "pages#privacy"
  get "/terms", to: "pages#terms"

  # Auth (mock)
  get "/signup", to: "pages#signup"
  get "/login", to: "pages#login"

  # Lead capture
  resources :leads, only: [:create]

  # API v1
  scope module: :api do
    namespace :v1 do
      get "/search", to: "search#index"
      post "/enrich", to: "enrich#create"
      post "/resolve", to: "resolve#create"
    end
  end

  # Status and health
  get "/status", to: "status#show"
  get "/healthz", to: "status#health"
  get "/sitemap.xml", to: "sitemaps#index", defaults: { format: :xml }
end
