module MCMarkdown
  module Image

    def image link, title, alt_text
      output = "<img src='#{link}' alt='#{alt_text}' />"
      if title
        title = ::Redcarpet::Markdown.new( self ).render(title).strip
        return "<figure class='img'>" << output << "<figcaption>#{title}</figcaption></figure>"
      else
        return output
      end
    end

  end
end