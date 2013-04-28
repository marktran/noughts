require 'sinatra/base'
require 'sinatra/assetpack'

class Noughts < Sinatra::Base
  register Sinatra::AssetPack

  assets do
    css :application, ['/css/application.css']
    js  :application, [
      '/js/vendor/jquery.*.js',
      '/js/vendor/*.js',
      '/js/*.js'
    ]
  end

  get '/' do
    erb :index
  end
end

Noughts.run!
