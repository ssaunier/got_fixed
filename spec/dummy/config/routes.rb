Rails.application.routes.draw do
  mount GotFixed::Engine => "/got_fixed"

  root :to => redirect("/got_fixed")
end
