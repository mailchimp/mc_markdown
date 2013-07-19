class App
  get '/' do
    @document = Document.create( :content => "" )
    response.redirect "/doc/#{@document.slug}"
  end

  get '/doc/:slug' do
    @document = Document.where( :slug => request.params[:slug] ).first
    render "app/views/_layout.haml" do
      render "app/views/index.haml"
    end
  end

  post '/doc/:slug/save' do
    @document = Document.where( :slug => request.params[:slug] ).first
    @document.update( :name => request.POST['name'], :content => request.POST['content'] )
    response.redirect "/doc/#{@document.slug}"
  end

  get '/scripts/site.js' do
    render 'app/views/scripts/site.js.coffee'
  end

  get '/css/site.css' do
    render 'app/views/css/site.css.scss'
  end

  post '/to_html' do
    begin
      MD.render( request.POST['content'] )
    rescue Exception => msg
      "Rendering Error:\n#{msg}"
    end
  end

  post '/to_md' do
    begin
      response.headers['Content-disposition'] = "attachment; filename='#{request.params["title"].to_slug}.md'"
      request.params["content"]
    rescue Exception => msg
      "Rendering Error:\n#{msg}"
    end
  end
end
