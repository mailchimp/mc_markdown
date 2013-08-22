module MCMarkdown
  class Base < Redcarpet::Render::HTML
    include ::MCMarkdown::Lists
    include ::MCMarkdown::Image
    include ::MCMarkdown::Links
    include ::MCMarkdown::SafeMergeTags
    include ::MCMarkdown::CommonMisspellings
    include ::MCMarkdown::Blockquote
    include ::MCMarkdown::Blocks
  end
end