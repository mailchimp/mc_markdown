module MCMarkdown
  class Guidebook < MCMarkdown::Base
    include ::MCMarkdown::HeaderWithID

    def initialize extensions={}
      @extensions = extensions
      super extensions
    end
  end
end