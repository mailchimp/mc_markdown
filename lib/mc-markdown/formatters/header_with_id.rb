require 'slugity/extend_string'

module MCMarkdown
  module Formatter
    module HeaderWithID

      def header text, header_level
        return "<h#{header_level}>#{text}</h#{header_level}>" if header_level != 1

        slug = text.strip.to_slug
        default = "section"
        if defined?(extensions)
          options = extensions.fetch(:header_with_id, {})
        else
          options = {}
        end

        # add ids to all h1 headers (pray they're unique)
        if defined?(extensions) && extensions.fetch(:template_tag_headers, false)
          namespace = "{{section_id}}"
        else
          namespace = "#{options.fetch(:slug, default)}-#{slug}"
        end

        return "<h#{header_level} id='#{namespace}'>#{text}</h#{header_level}>"
      end

    end
  end
end