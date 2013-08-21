module MCMarkdown
  module Extensions
    attr_reader :extensions

    def initialize extensions={}
      @extensions = extensions
      super extensions
    end
  end
end