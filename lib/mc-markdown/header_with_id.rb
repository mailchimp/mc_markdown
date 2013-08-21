require 'slugity/extend_string'

module MCMarkdown
  module HeaderWithID

    def header text, header_level
      return "<h#{header_level}>#{text}</h#{header_level}>" if header_level != 1

      slug = text.strip.to_slug
      default = "section"

      # add ids to all h1 headers (pray they're unique)
      if defined?(extensions)
        if extensions.fetch(:template_tag_headers){ false }
          namespace = "{{section_id}}"
        else
          namespace = "#{ extensions.fetch(:slug){ default } }-#{slug}"
        end
      else
        namespace = "#{default}-#{slug}"
      end

      return "<h#{header_level} id='#{namespace}'>#{text}</h#{header_level}>"
    end

    def self.included mod
      unless defined?(extensions)
        mod.send :include, Extensions
      end
    end

  end
end