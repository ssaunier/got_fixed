GotFixed::Engine.routes.draw do
  resources :issues, :only => [:index] do
    collection do
      post :github_webhook
      post :subscribe
    end
  end

  root :to => "issues#index"
end
