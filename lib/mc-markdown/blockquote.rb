module MCMarkdown
  module Blockquote

    BLOCK_QUOTE_PATTERN = /^>.*$\n(\n*)^>/

    def preprocess doc
      doc.gsub(BLOCK_QUOTE_PATTERN) do |match|
        match << " {{break_quote}}"
      end
    end

    def block_quote quote

      quote = quote.strip.gsub( "<p>{{break_quote}} ", '</blockquote><blockquote><p>').gsub(/\n/, '')

      "<blockquote>" << quote << "</blockquote>"
    end

  end
end