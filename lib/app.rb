require 'rack'
require 'rack/contrib/try_static'
require 'hobbit'

require 'markdown'

class App < Hobbit::Base
  include Hobbit::Render
  include MCMarkdown

  use Rack::MethodOverride
  use Rack::Static, root: 'source', urls: ['/scripts/jquery.js']

  RENDERER = Redcarpet::Markdown.new( MCMarkdown::Base )

  get '/' do
    render "source/_layout.haml" do
      render "source/index.haml"
    end
  end

  get '/scripts/site.js' do
    render 'source/scripts/site.js.coffee'
  end

  post '/to_html' do
    RENDERER.render( request.POST['markdown'] )
  end

end