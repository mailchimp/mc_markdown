module MCMarkdown
  module HeaderWithID

    def header text, header_level

      # remove a leading or trailing space if it is there
      text.gsub!( /(^\s)|(\s$)/, '' )
      slug = text.to_slug

      # add ids to all h1 headers (pray they're unique)
      if defined? extensions[:template_tag_headers] && extensions[:template_tag_headers]
        namespace = "{{section_id}}"
      else
        namespace = ( defined? extensions[:slug] ) ? "extensions[:slug]" : "section"
        namespace << "-#{slug}"
      end


      if header_level == 1
        return "<h1 id='#{namespace}'>#{text}</h1>"
      else
        return "<h#{header_level}>#{text}</h#{header_level}>"
      end

    end

  end
end