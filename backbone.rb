# Get ready to kick ass.
require 'sinatra'
require 'sinatra/async'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'dm-core'
require 'dm-constraints'
require 'dm-migrations'
require 'dm-timestamps'
require 'dm-serializer'
require 'slim'
require 'sass'
require 'compass'
require 'zurb-foundation'
require './models/posts'

unless ENV['RACK_ENV'].nil? || ENV['RACK_ENV'] == ''
  DataMapper.setup( :default, "sqlite://#{Sinatra::Application.root}/db/#{ENV['RACK_ENV']}.db" )
end

DataMapper.auto_upgrade!

configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
  set :template_engine, :slim
end

class Backbone < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  register Sinatra::Async

  get '/' do
   slim :index
  end

  get '/stylesheets/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss(:"scss/#{params[:name]}", Compass.sass_engine_options)
  end
end
