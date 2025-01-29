Rails.application.routes.draw do
  resources :jobs

  # ルートパスを"jobs#index"に設定
  root "jobs#index"
end

