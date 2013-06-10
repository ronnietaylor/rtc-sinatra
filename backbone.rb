# Get ready to kick ass.
require 'sinatra'
require 'sinatra/partial'
require 'sinatra/assetpack'
require 'slim'
require 'sass'
require 'compass'
require 'zurb-foundation'

configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
  set :template_engine, :slim
  set :partial_template_engine, :slim
  enable :partial_underscores
  set :format => :html5
  set :root, File.dirname(__FILE__)
end

configure :production, :development do
  enable :logging
end

class Backbone < Sinatra::Base
  register Sinatra::AssetPack
  register Sinatra::Partial

  assets {
    serve '/js',      from: 'assets/js'
    serve '/css',     from: 'assets/css'
    serve '/images',  from: 'assets/images'

    # The second parameter defines where the compressed version will be served.
    # (Note: that parameter is optional, AssetPack will figure it out.)
    js :app, '/js/app.js', [
      '/js/vendor/**/*.js',
      '/js/lib/**/*.js'
    ]

    css :application, '/css/application.css', [
      '/css/screen.css'
    ]

    js_compression  :jsmin    # :jsmin | :yui | :closure | :uglify
    css_compression :sass   # :simple | :sass | :yui | :sqwish
  }

  get '/' do
   slim :index
  end

  get '/blog' do
   slim :blog
  end

  get '/stylesheets/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss(:"scss/#{params[:name]}", Compass.sass_engine_options)
  end
end
