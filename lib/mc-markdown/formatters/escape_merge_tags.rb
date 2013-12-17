module MCMarkdown
  module Formatter
    module EscapeMergeTags
      ALLOWED_CHARACTERS = ['w', ':', '_', '<', '>', '/' ]

      def emphasis text
        characters = ALLOWED_CHARACTERS.map { |char| "\\#{char}" }.join("")
        unless text.match /^\| .+ \|$/x
          "<em>#{text}</em>"
        else
          "*#{convert_em_tags_to_underscores(text)}*"
        end
      end

      def convert_em_tags_to_underscores string
        string.gsub( /<\/?em>/, '_' )
      end

    end
  end
end