module MCMarkdown
  module SafeMergeTags

    def emphasis text
      unless /^\| [\w|\:]* \|$/x.match(text)
        "<em>#{text}</em>"
      else
        "*#{text}*"
      end
    end

  end
end