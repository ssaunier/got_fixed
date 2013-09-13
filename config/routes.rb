GotFixed::Engine.routes.draw do
  resources :issues, :only => [:index]

  root :to => "issues#index"
end
