Refinery::Core::Engine.routes.draw do

  # Admin routes
  namespace :admin, :path => 'refinery' do
    resources :page_menus do
      post :update_positions, :on => :collection
      resources :page_positions, :only => :index do
        post :update_positions, :on => :collection
      end
    end
    
    # if Refinery::PageMenus.pages_overview
    #   get '/pages' => 'pages#list'
    # else
    #   get '/pages' => 'pages#index'
    # end
    # 
    # get '/pages/main_menu' => 'pages#index', :as => "pages_main_menu"
    # get '/pages/main_menu/edit' => 'page_menus#edit_main_menu', :as => "edit_main_menu"
    # post '/pages/main_menu' => 'page_menus#update_main_menu', :as => "update_main_menu"
    
  end
end
