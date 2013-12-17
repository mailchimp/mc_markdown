require 'slugity/extend_string'

module MCMarkdown
  module Formatter
    module HeaderWithID

      def header text, header_level
        return "<h#{header_level}>#{text}</h#{header_level}>" if header_level != 1

        # add ids to all h1 headers (pray they're unique)
        if header_options.fetch(:template_tag_headers, false)
          namespace = "{{section_id}}"
        else
          namespace = "#{header_options.fetch(:slug, 'section')}-#{text.strip.to_slug}"
        end

        return "<h#{header_level} id='#{namespace}'>#{text}</h#{header_level}>"
      end

      def header_options
        if defined?(extensions)
          options = extensions.fetch(:header_with_id, {})
          options[:template_tag_headers] = extensions.fetch(:template_tag_headers, false)
        else
          options = {}
        end

        return options
      end

    end
  end
end