module MCMarkdown
  module Formatter
    module Image

      # http://rubular.com/r/lss0C9HqoP
      # $1 => alt
      # $2 => class/attrs
      IMG_ATTRIBUTES_PATTERN = /^ ([^_{}]+)? (?:{(.+?)})? \s?$/x

      # add classes to images and render title as figure/figcaption
      # ![alt {class}](/path/to/img.jpg "caption")
      def image link, title, alt_text
        return "![#{alt_text}](#{link}#{(title && !title.empty?) ? " \"#{title}\"" : ''})" if extensions[:no_images]

        match_data = IMG_ATTRIBUTES_PATTERN.match (alt_text || "")
        alt_text = match_data[1] || ""
        attrs    = match_data[2] || ""

        # check for attrs in class field
        if attrs.include? ':'
          attrs = attrs.split(', ').each_with_object([]) do |frag, out|
            frag = frag.split ':'
            out.push "#{frag[0].strip}='#{frag[1].strip}'"
            out
          end.join(" ") + " "
        elsif !attrs.empty?
          classes = attrs
          attrs   = "class='#{attrs}' "
        end

        if title
          return "<figure class='img #{classes}'>" +
                 "<img src='#{link}' alt='#{alt_text.strip}' />" +
                 "<figcaption>" + ::Redcarpet::Markdown.new( self ).render(title).strip + "</figcaption>" +
                 "</figure>"
        else
          return "<img src='#{link}' alt='#{alt_text.strip}' #{attrs}/>"
        end
      end

      # need to strip paragraph tags from around
      # figures, has potential to cause invalid markup
      def postprocess doc
        doc = doc.gsub( /<p><figure/, '<figure' ).gsub( /<\/figure><\/p>/, '</figure>' )

        if defined?(super)
          return super(doc)
        else
          return doc
        end
      end

    end
  end
end