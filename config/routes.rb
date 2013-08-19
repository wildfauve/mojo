Mojo::Application.routes.draw do

  root :to => "welcome#index"

#  match 'api/' => 'apiroot#index'
  namespace :api do
    resources :crimes do
      collection do
        resources :years, :only => [:show, :index]
      end
    end
    resources :crimeaggregations do
      collection do
        resources :by_year, :only => [:show, :index]
      end
    end  
      
  end
  
  resources :crimes
  resources :dashboards, :only => :index
  
  resources :welcome, :only => :index

end