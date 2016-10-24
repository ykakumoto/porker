Rails.application.routes.draw do
  root 'porker#new'
  get 'porker' => 'porker#new'
  post 'porker' => 'porker#porkerhand'
  mount PorkerApi::API => '/'
end
