require 'markdown'

class App < Scorched::Controller
  include MCMarkdown

  render_defaults[:dir] = 'views'
  render_defaults[:layout] = :'layout.haml'
  render_defaults[:engine] = 'haml'

  RENDERER = Redcarpet::Markdown.new( MCMarkdown::Base )

  def render_markdown markdown
    string = RENDERER.render( markdown )
    render string, :engine => "erb"
  end

  get '/' do
    render :"index.haml"
  end

  post '/to_html' do
    RENDERER.render( request.POST['markdown'] )
  end

end