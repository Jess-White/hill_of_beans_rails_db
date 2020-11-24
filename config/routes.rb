Rails.application.routes.draw do

  namespace :api do
    get "/films" => "films#index"
    post "/films" => "films#create"
    get "/films/:id" => "films#show"
  end
end
