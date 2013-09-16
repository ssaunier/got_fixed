GotFixed::Engine.routes.draw do
  resources :issues, :only => [:index] do
    collection do
      post :github_webhook
    end
  end

  root :to => "issues#index"
end
