module MCMarkdown
  module Formatter
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
          text = text.gsub( match_data[1].gsub(/\<\/?p\>/,''), '')

          # strip opening and closing p tags
          text = text.strip.gsub( /(\A\<p\>|\<\/p\>\z)/, '' )

          text = "<p>" << text << "</p>"

          "<dt>#{title}</dt><dd>#{text}</dd>"
        else
          "<li>#{text.strip}</li>"
        end
      end

    end
  end
end