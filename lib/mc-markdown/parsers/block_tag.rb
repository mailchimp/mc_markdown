module MCMarkdown
  module Parser

    class BlockTag

      attr_reader :content
      attr_reader :formatter

      def initialize content, formatter
        @content = content
        @formatter = formatter.new
      end

      def parsed
        content.gsub Block.pattern do |match|
          tag = Block.new(match)
          formatter.format(tag)
        end
      end

      class Block
        def self.pattern
          / \{\{ (.*?) \}\} (.*?) \{\{\/ (.*?) \}\} /xm
        end

        attr_reader :orig
        attr_reader :type
        attr_reader :attributes

        def initialize content
          @orig = content
        end

        def type
          @_type ||= @orig.match( Block.pattern )[1]
        end

        def attributes
          @_attributes ||= { content: @orig.match( Block.pattern )[2].strip }
        end
      end
    end

  end
end