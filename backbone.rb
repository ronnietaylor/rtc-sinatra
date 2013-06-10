# Get ready to kick ass.
require 'sinatra'
require 'slim'
require 'sass'
require 'compass'
require 'zurb-foundation'

configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
  set :template_engine, :slim
  set :format => :html5
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
