# Rack Middleware
require 'rack'
require 'rack/contrib/try_static'

# Utility
require 'slugity/extend_string'

# Framework Stuff
require 'hobbit'
require 'sequel'

# Renderers
require 'haml'
require 'sass'
require 'coffee_script'
require 'mc-markdown'

class App < Hobbit::Base
  include Hobbit::Render

  use Rack::MethodOverride
  use Rack::Static, root: 'app/views', urls: Dir['app/views/**/*'].keep_if { |f| /\.(css|js)\z/.match(f) }.map{ |f| f.gsub(/(^source)/, '') }

  MD = Redcarpet::Markdown.new( MCMarkdown::Base )
  DB = Sequel.connect(ENV['HEROKU_POSTGRESQL_AMBER_URL'] || 'postgres://localhost/mc_markdown')

  require 'models/document'

  require 'controllers/application_controller'

end