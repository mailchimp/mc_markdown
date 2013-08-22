module MCMarkdown
  module Formatter
    module Blocks
      BLOCK_PATTERN = "\{\{ (\/?) (notes|callout) \}\}"

      # Ensure each open and close tag is on new line
      def preprocess doc
        doc.gsub!( /(#{BLOCK_PATTERN})(.*?)(#{BLOCK_PATTERN})/mx ) do
          open    = $1
          content = $4.strip
          close   = $5

          "\n\n#{open}\n\n#{content}\n\n#{close}\n\n"
        end

        if defined?(super)
          return super(doc)
        else
          return doc
        end
      end

      # Replace blocks enclosed in paragraphs with divs
      def postprocess doc
        doc.gsub!( /<p>#{BLOCK_PATTERN}<\/p>/x ) do
          is_closing_tag = ($1 == "/")
          block_type = $2

          if is_closing_tag
            "</div>"
          else
            "<div class=\"#{block_type}\">"
          end
        end

        if defined?(super)
          return super(doc)
        else
          return doc
        end
      end

    end
  end
end