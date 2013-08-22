module MCMarkdown
  module Formatter
    module Image

      # Captures classes
      # $1 => class
      IMG_CLASSES_PATTERN = /.* \{(.*)\}\s?$ /x

      # add classes to images and render title as figure/figcaption
      # ![alt {class}](/path/to/img.jpg "caption")
      def image link, title, alt_text

        classes = nil
        img_class = ""

        if IMG_CLASSES_PATTERN.match(alt_text)
          classes = IMG_CLASSES_PATTERN.match(alt_text)[1]
          alt_text.gsub!( /\s?\{#{classes}\}\s?/, '' )
        end

        if title
          title = ::Redcarpet::Markdown.new( self ).render(title).strip
          img_tag = "<img src='#{link}' alt='#{alt_text}' />"
          return "<figure class='img #{classes}'>" << img_tag << "<figcaption>#{title}</figcaption></figure>"
        else
          classes = "class='#{classes}' " if classes
          img_tag = "<img src='#{link}' alt='#{alt_text}' #{classes}/>"
          return img_tag
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