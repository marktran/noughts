require 'sinatra/base'
require 'sinatra/assetpack'

class Noughts < Sinatra::Base
  register Sinatra::AssetPack

  assets do
    css :application, ['/css/application.css']
    js  :app, ['/js/vendor/*.js', '/js/*.js']
  end

  get '/' do
    erb :index
  end
end

Noughts.run!
