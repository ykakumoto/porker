Rails.application.routes.draw do
  root 'check#new'
  get 'check' => 'check#new'
  post 'check' => 'check#handcheck'
  mount PorkerApi::API => '/'
end
