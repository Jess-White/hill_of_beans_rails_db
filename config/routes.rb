Rails.application.routes.draw do

  namespace :api do
    get "/films" => "films#index"
    post "/films" => "films#create"

    get "/films/search" => "films#search"

    patch "/films/:imdb" => "films#update"

    get "/films/:imdb" => "films#show"
  end
end
