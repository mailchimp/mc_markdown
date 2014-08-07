module MCMarkdown
  module Formatter
    module Blockquote

      # http://rubular.com/r/eZv1W4mpfX
      BLOCK_QUOTE_PATTERN = /^>.*$  \n^[^>]/x

      def preprocess doc
        doc.gsub!(BLOCK_QUOTE_PATTERN) do |match|
          match << "\n{{break_quote}}\n"
        end

        if defined?(super)
          return super(doc)
        else
          return doc
        end
      end

      def postprocess doc
        doc.gsub! "\n<p>{{break_quote}}</p>", ""

        if defined?(super)
          return super(doc)
        else
          return doc
        end
      end

      def block_quote quote
        quote = quote.strip.gsub( "<p>{{break_quote}} ", '</blockquote><blockquote><p>').gsub(/\n/, '')

        "<blockquote>" << quote << "</blockquote>"
      end

    end
  end
end