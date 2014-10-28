module MCMarkdown
  module Parsers

    class Frontmatter
      attr_reader :content

      def initialize content
        @content = content
      end

      def parsed
        match   = content.match( frontmatter_regex )
        raw_fm  = match[1]
        content = match[2]

        if raw_fm && !raw_fm.empty?
          frontmatter = SafeYAML.load raw_fm, safe: true,
                                              deserialize_symbols:  true,
                                              raise_on_unknown_tag: true
        else
          frontmatter = {}
        end

        [ frontmatter, content ]
      end

      private

        def frontmatter_regex
          # http://rubular.com/r/tJ6VoFBuqK
          # [1] => frontmatter || nil
          # [2] => content
          /(?:(?:\A-{3,}\s*\n+) (.+?) (?:-{3,}\s*\n+))? (.*)/mx
        end

    end

  end
end
