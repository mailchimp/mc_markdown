module MCMarkdown
  module Formatter
    module Blocks

      def preprocess doc
        doc.gsub!( Parser::BlockTag::Block.open_block ) do |match|
          "\n\n#{match}\n\n"
        end

        doc.gsub!( Parser::BlockTag::Block.close_block ) do |match|
          "\n\n#{match}\n\n"
        end

        # binding.pry

        if defined?(super)
          return super(doc)
        else
          return doc
        end
      end

      def postprocess doc
        doc = Parser::BlockTag.new(doc, BlockFormatter).parsed

        if defined?(super)
          return super(doc)
        else
          return doc
        end
      end

      class BlockFormatter < Parser::Formatter

        def notes attributes={}
          content = attributes[:content]
          "<div class=\"notes\">\n\n#{content}\n\n</div>"
        end

        def callout attributes={}
          content = attributes[:content]
          "<div class=\"callout\">\n\n#{content}\n\n</div>"
        end

      end

    end
  end
end