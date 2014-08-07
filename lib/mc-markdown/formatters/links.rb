module MCMarkdown
  module Formatter
    module Links

      # http://rubular.com/r/nVJvYdiGud
      # $1 => text
      # $2 => junk
      # $3 => class/attrs
      # $4 => target
      LINK_ATTRIBUTES_PATTERN = /^ ([^_{}]+) ({(.+?)})? (\s\_[a-zA-Z]+)? \s?$/x


      # add ability to add classes to links
      # [Link Test {class} _target ](link)
      def link link, title, content
        return "[#{content}](#{link}#{(title && !title.empty?) ? " \"#{title}\"" : ''})" if extensions[:no_links]

        match_data = LINK_ATTRIBUTES_PATTERN.match content
        content    = match_data[1]
        attrs      = match_data[3] || ""
        target     = match_data[4]

        # check for attrs in class field
        if attrs.include? ':'
          attrs = attrs.split(', ').each_with_object([]) do |frag, out|
            frag = frag.split ':'
            out.push "#{frag[0].strip}='#{frag[1].strip}'"
            out
          end.join(" ")
        elsif !attrs.empty?
          attrs = "class='#{attrs}'"
        end

        if extensions[:xml]
          link.encode!(xml: :text)
          # content gets loosely encoded before it
          # enters the formatter
        end

        # there is always a link
        return_string = "<a href='#{link}'"
        return_string << " " << attrs                if !attrs.empty?
        return_string << " target='#{target.strip}'" if target
        return_string << ">#{content.strip}</a>"

        return return_string
      end

    end
  end
end