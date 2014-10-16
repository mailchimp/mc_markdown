module MCMarkdown
  class Guidebook < MCMarkdown::Base
    include ::MCMarkdown::Formatter::HeaderWithID
  end
end