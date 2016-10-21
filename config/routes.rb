Rails.application.routes.draw do
  get 'check' => 'check#new'
  post 'check' => 'check#handcheck'
end
