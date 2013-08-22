module MCMarkdown
  class Base < Redcarpet::Render::HTML
    include ::MCMarkdown::Formatter::Lists
    include ::MCMarkdown::Formatter::Image
    include ::MCMarkdown::Formatter::Links
    include ::MCMarkdown::Formatter::EscapeMergeTags
    include ::MCMarkdown::Formatter::CommonMisspellings
    include ::MCMarkdown::Formatter::Blockquote
    include ::MCMarkdown::Formatter::Blocks
  end
end