Refinery::Core::Engine.routes.draw do

  namespace :admin, :path => 'refinery' do
    resources :page_menus, :only => [:edit, :update] do
      resources :page_positions, :only => :index do
        post :update_positions, :on => :collection
      end
    end
    
    get '/pages' => 'pages#list'
    get '/pages/main_menu' => 'pages#index', :as => "pages_main_menu"
    
  end
end
