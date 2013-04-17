require 'redcarpet'

module MCMarkdown

  module Lists

    def list content, list_type
      tag = ( list_type == :ordered ) ? "ol" : "ul"
      tag = (/\<dt\>/.match(content) ) ? "dl" : tag

      "<#{tag} class='list markers'>#{content}</#{tag}>"
    end

    def list_item text, list_type
      if /\n\:\s*\n/.match(text)
        match_data = /^((.*)\n\:\s*\n)/.match(text)
        title = "<p>" << match_data[2].gsub('<p>','') << "</p>"

        # strip the title from the text, but leave <p> tags
        text = text.gsub( match_data[1].gsub('<p>',''), '')

        # strip opening and closing p tags
        text = text.gsub( /(\A\<p\>|\<\/p\>\z)/, '' )

        text = "<p>" << text << "</p>"

        "<dt>#{title}</dt><dd>#{text}</dd>"
      else
        "<li>#{text}</li>"
      end
    end

  end

  module Image

    def image link, title, alt_text
      output = "<img src='#{link}' alt='#{alt_text}' />"
      if title
        title = ::Redcarpet::Markdown.new( self ).render(title)
        return "<figure class='img'>" << output << "<figcaption>#{title}</figcaption></figure>"
      else
        return output
      end
    end

  end

  module Links

    # Captures link classes
    # $1 => class
    # $2 => junk
    # $3 => target
    LINK_CLASSES_PATTERN = /.* \{(.*)\}\s? ( (_\w*)\s?$ )?/x

    # Captures link targets
    # $1 => junk
    # $2 => target_attr
    LINK_TARGET_PATTERN = /.* ( \{.*\}\s* )? (_\w*)\s?$/x


    # add ability to add classes to links
    # [Link Test {class} _target ](link)
    def link link, title, content

      # default classes and target to nil
      classes = nil
      target = nil

      # there is always a link
      return_string = "<a href='#{link}'"

      # check for classes or targets
      if LINK_CLASSES_PATTERN.match(content)
        match_data = LINK_CLASSES_PATTERN.match(content)

        # there is a class and maybe a target
        classes = match_data[1]
        target = match_data[3]


      elsif LINK_TARGET_PATTERN.match(content)
        match_data = LINK_TARGET_PATTERN.match(content)

        # there is a target and no class
        # (because we passed the class pattern)
        classes = nil
        target = match_data[2]

      end

      # add the target and classes params
      return_string << " class='#{classes}'" if classes
      return_string << " target='#{target}'" if target

      # remove classes and target from the content
      content.gsub!( /\s?\{#{classes}\}\s?/, "" ) if classes
      content.gsub!( /\s?#{target}\s?/, "" ) if target

      # close that tag with the content
      return_string << ">#{content}</a>"

      return return_string
    end

  end

  module HeaderWithID

    def header text, header_level

      # remove a leading or trailing space if it is there
      text.gsub!( /(^\s)|(\s$)/, '' )
      slug = text.to_slug

      # add ids to all h1 headers (pray they're unique)
      if defined? extensions[:template_tag_headers] && extensions[:template_tag_headers]
        namespace = "{{section_id}}"
      else
        namespace = ( defined? extensions[:slug] ) ? "extensions[:slug]" : "section"
        namespace << "-#{slug}"
      end


      if header_level == 1
        return "<h1 id='#{namespace}'>#{text}</h1>"
      else
        return "<h#{header_level}>#{text}</h#{header_level}>"
      end

    end

  end

  module SafeMergeTags

    def emphasis text
      unless /^\| [\w|\:]* \|$/x.match(text)
        "<em>#{text}</em>"
      else
        "*#{text}*"
      end
    end

  end

  module CommonMisspellings
    def preprocess doc
      replacements = {
        "(&ldqou;)"  =>  "&ldquo;",
        "(&rdqou;)"  =>  "&rdquo;",
        "(&rsqou;)"  =>  "&rsquo;"
      }
      replacements.each do |bad_regex, correction|
        doc.gsub! /#{bad_regex}/xi, correction
      end
      doc
    end
  end

  class Base < Redcarpet::Render::HTML
    include ::MCMarkdown::Lists
    include ::MCMarkdown::Image
    include ::MCMarkdown::Links
    include ::MCMarkdown::SafeMergeTags
    include ::MCMarkdown::CommonMisspellings
  end

end