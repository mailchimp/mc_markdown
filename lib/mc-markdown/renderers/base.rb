module MCMarkdown
  class Base < Html
    include ::MCMarkdown::Formatter::Lists
    include ::MCMarkdown::Formatter::Image
    include ::MCMarkdown::Formatter::Links
    include ::MCMarkdown::Formatter::EscapeMergeTags
    include ::MCMarkdown::Formatter::CommonMisspellings
    include ::MCMarkdown::Formatter::Blockquote
    include ::MCMarkdown::Formatter::Blocks
    include ::MCMarkdown::Formatter::Wistia
  end
end