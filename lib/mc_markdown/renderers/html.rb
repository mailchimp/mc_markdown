module MCMarkdown
  class Html < Redcarpet::Render::HTML
    include Extensions
  end
end