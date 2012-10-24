require 'sinatra'
require 'haml'
require 'coffee-script'
require 'sass'

set :haml, {:format => :html5} # default Haml format is :xhtml
set :app_file, __FILE__

def haml_layout(name)
  haml :"#{name}.html", layout: :'layouts/application.html'
end

# Serve sass/coffee/static files
get '/stylesheets/:name' do
  content_type 'text/css', :charset => 'utf-8'
  sass :"stylesheets/#{params[:name]}"
end

get '/javascripts/:name' do
  content_type 'text/javascript', :charset => 'utf-8'
  coffee :"javascripts/#{params[:name]}"
end

get '/public/:name' do
  File.read(File.join(settings.public_folder, params[:name]))
  
end

# Handle requests!
get '/' do
  haml_layout "index"
end
