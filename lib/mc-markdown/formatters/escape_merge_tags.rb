module MCMarkdown
  module Formatter
    module EscapeMergeTags

      def emphasis text
        unless /^\| [\w|\:|\_|<|>|\/]* \|$/x.match(text)
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