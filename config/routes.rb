Rails.application.routes.draw do
  root to: 'basic_qr_codes#index'
  get 'basic-qr-code-reader', to: 'basic_qr_codes#index'
end
