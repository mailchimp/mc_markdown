module MCMarkdown
  module Parser

    module Formatter

      def format tag
        if self.respond_to? tag.type
          self.public_send(tag.type, tag.attributes)
        else
          tag.orig
        end
      end

    end

    class ShortTag

      attr_reader :content
      attr_reader :formatter

      def initialize content, formatter
        @content = content
        @formatter = formatter.new
      end

      def parsed
        content.gsub Tag.pattern do |match|
          tag = Tag.new(match)
          formatter.format(tag)
        end
      end

      class Tag

        def self.pattern
          /\{\{ (.*?) \}\}/x
        end

        attr_reader :orig
        attr_reader :type
        attr_reader :attributes

        def initialize matched_string
          @orig = matched_string
          @data = @orig.match( Tag.pattern )[1].strip.split(' ')
          @type = @data.shift
          @attributes = @data.map { |set| set.scan( attribute_pattern ) }.map { |pair| { pair[0][0] => pair[0][1] } }
        end

        private

          def attribute_pattern
            / (\w+) = ['"](.+?)['"] /x
          end

      end

    end
  end
end
