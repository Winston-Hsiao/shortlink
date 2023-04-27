Rails.application.routes.draw do
  post '/encode', to: 'shortened_urls#encode'
  post '/decode', to: 'shortened_urls#decode'
end
