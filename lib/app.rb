require 'markdown'

class App < Scorched::Controller
  include MCMarkdown

  render_defaults[:dir] = 'source'
  render_defaults[:layout] = :'_layout.haml'
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