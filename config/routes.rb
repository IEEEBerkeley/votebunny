Votebunny::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  root :to => 'sessions#show', :as => 'home'
  # login
  match '/login' => 'sessions#show', :via => :get, :as => 'show_login'
  match '/login' => 'sessions#login', :via => :post, :as => 'login'
  match '/logout' => 'sessions#destroy', :as => 'logout'
  # elections
  match '/elections' => 'elections#index', :as => 'elections'
  match '/election/:eid' => 'elections#show', :as => 'election'
  # positions
  match '/election/:eid/position/:pid' => 'positions#show', :via => :get, :as => 'position'
  match '/election/:eid/position/:pid' => 'positions#vote', :via => :post, :as => 'vote'
  # admin stuff
  match '/admin' => 'admin#index', :as => 'admin'
  match '/admin/election/new' => 'admin#new_election', :as => 'new_election'
  match '/admin/election/create' => 'admin#create_election', :as => 'create_election'
  match '/admin/election/:eid' => 'admin#show', :as => 'admin_election'
  match '/admin/election/:eid/edit' => 'admin#edit_election', :as => 'edit_election'
  match '/admin/election/:eid/update' => 'admin#update_election', :as => 'update_election'

  match '/admin/election/:eid/position/new' => 'admin#new_position', :as => 'new_position'
  match '/admin/election/:eid/position/create' => 'admin#create_position', :as => 'create_position'
  match '/admin/election/:eid/position/:pid/edit' => 'admin#edit_position', :as => 'edit_position'
  match '/admin/election/:eid/position/:pid/update' => 'admin#update_position', :as => 'update_position'

  match '/admin/election/:eid/position/:pid/candidate/new' => 'admin#new_candidate', :as => 'new_candidate'
  match '/admin/election/:eid/position/:pid/candidate/create' => 'admin#create_candidate', :as => 'create_candidate'

  match '/admin/election/:eid/user/create' => 'admin#create_user', :as => 'create_user'
  match '/admin/election/:eid/users/' => 'admin#view_users', :as => 'view_users'
end
