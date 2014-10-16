module MCMarkdown
  module Parser

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
          @attributes = @data.map { |set| set.scan( attribute_pattern ) }.inject({}) do |out,pair|
            out[ pair[0][0].to_sym ] = pair[0][1]
            out
          end
        end

        private

          def attribute_pattern
            / (\w+) = ['"](.+?)['"] /x
          end

      end

    end
  end
end
