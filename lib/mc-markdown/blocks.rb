module MCMarkdown
  module Blocks
    BLOCK_PATTERN = /\{\{(\/?)(notes|callout)\}\}/

    # Ensure each open and close tag is on new line
    def preprocess doc
      doc.gsub!(BLOCK_PATTERN) do |match|
        "\n#{match}\n"
      end

      if defined?(super)
        return super(doc)
      else
        return doc
      end
    end

    # Replace blocks enclosed in paragraphs with divs
    def postprocess doc
      doc.gsub!(/<p>#{BLOCK_PATTERN}<\/p>/) do |match|
        matches = match.match(BLOCK_PATTERN)
        if matches[1] == "/"
          "</div>"
        else
          "<div class=\"#{matches[2]}\">"
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