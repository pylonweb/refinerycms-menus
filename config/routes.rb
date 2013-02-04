Refinery::Core::Engine.routes.draw do

  # Admin routes
  namespace :admin, :path => 'refinery' do
    resources :menu_links, only: [:create, :destroy]

    resources :menus do
      post :update_positions, :on => :collection
      resources :menu_links, :only => [:index, :show] do
        post :update_positions, :on => :collection
      end
    end
    
  end
end
