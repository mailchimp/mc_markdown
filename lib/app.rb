require 'rack'
require 'rack/contrib/try_static'
require 'hobbit'

require 'markdown'

class App < Hobbit::Base
  include Hobbit::Render
  include MCMarkdown

  use Rack::MethodOverride
  use Rack::Static, root: 'source', urls: Dir['source/**/*'].keep_if { |f| /\.(css|js)\z/.match(f) }.map{ |f| f.gsub(/(^source)/, '') }

  def initialize
    @renderer = Redcarpet::Markdown.new( MCMarkdown::Base )
  end

  get '/' do
    render "source/_layout.haml" do
      render "source/index.haml"
    end
  end

  get '/scripts/site.js' do
    render 'source/scripts/site.js.coffee'
  end

  get '/css/site.css' do
    render 'source/css/site.css.scss'
  end

  post '/to_html' do
    begin
      @renderer.render( request.POST['markdown'] )
    rescue Exception => msg
      "Rendering Error:\n#{msg}"
    end
  end

  post '/file.md' do
    begin
      response.headers['Content-disposition'] = 'attachment'
      @renderer.render( request.POST['markdown'] )
    rescue Exception => msg
      "Rendering Error:\n#{msg}"
    end
  end

end