require 'redcarpet'

module MCMarkdown
  def md
    "hello from md"
  end

  class Base < Redcarpet::Render::HTML
  end
end