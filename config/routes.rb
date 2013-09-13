GotFixed::Engine.routes.draw do
  resources :issues, :only => [:index]
end
