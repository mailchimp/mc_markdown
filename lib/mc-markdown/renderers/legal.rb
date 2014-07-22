require 'nokogiri'
require 'slugity'

module MCMarkdown

  class Legal < Redcarpet::Render::HTML
    include Extensions
    include Formatter::Links

    def list_item text, list_type
      text.gsub!(/(^\<p\>)|\<\/p\>$/, '')
      "<li>" << text << "</li>"
    end

    # process the document to add tooltips
    # return [String]
    def postprocess doc

      html = Nokogiri::HTML(doc)
      html.xpath('//h2')

      section_count = html.xpath('//h2').length

      if section_count > 0
        return process_sections( parse_sections( html, section_count ) )
      else
        section_count = html.xpath('//h1').length
        if section_count > 0
          return process_h1_sections( doc )
        end
        return "<section class='col span2of3 normalize'>" << add_tooltips( doc ) << "</section>"
      end

    end

    # wraps the document but leaves h1 full width
    # @param [String]
    # @return [String]
    def process_h1_sections doc
      strung_doc = "<section class='col span2of3 normalize'>" << add_tooltips( doc ) << "</section>"
      strung_doc.gsub!( /(<h1>(.*?)<\/h1>)/ ).each do |match|
        "</section><section class='col span1of1'>" << $1 << "</section><section class='col span2of3 normalize'>"
      end
      return strung_doc
    end

    # wraps each section and adds tooltips
    # return [String]
    def process_sections sections_hash

      output = ""

      sections_hash.each do |section,content|
        section_content = ""

        unless /^header/.match(section)
          section_content << "<section id='#{section}'>"
          section_content << "<div class='col span2of3 normalize'>"
          content.each do |c|
            section_content << c.to_html
          end
          section_content << "</div>"
          section_content << "<div class='col span1of3 normalize'>"
          section_content = add_tooltips( section_content )
          section_content << "</div>"
          section_content << "</section>"
        else
          section_content << "<div class='legal-section-header col span1of1 normalize'>"
          section_content << content.first.to_html
          section_content << "</div>"
        end

        output << section_content
      end

      return output
    end

    # parses sections and adds them to a hash
    # return [Hash]
    def parse_sections nokogiri_document, count

      sections = {}
      (count+1).times do |idx|

        header = nokogiri_document.xpath("//h2[#{idx}]")
        if !header.first.nil? && header.first.previous_element.node_name == "h1"
          sections["header-#{idx}"] = [header.first.previous_element]
        end
        sections["section-#{idx}"] = []

        if idx == 0

          sections["section-#{idx}"] << nokogiri_document.xpath("//h2[#{idx+1}]/preceding-sibling::*[not(name()='h1')]")

        elsif idx > 0 && idx < count

          sections["section-#{idx}"] << header

          after = nokogiri_document.xpath("//h2[#{idx}]/following-sibling::*[not(name()='h1')]")
          before = nokogiri_document.xpath("//h2[#{idx+1}]/preceding-sibling::*[not(name()='h1')]")

          # compare the 'before h2' and 'after h2' sets and
          # include the ones that match are in both
          after.each do |node|
            if before.include? node
              sections["section-#{idx}"] << node
            end
          end

        else
          sections["section-#{idx}"] << header
          sections["section-#{idx}"] << nokogiri_document.xpath("//h2[#{idx}]/following-sibling::*[not(name()='h1')]")
        end
      end

      return sections

    end

    def add_tooltips content

      section_tooltips = []
      content.gsub!(ToolTip.pattern) do |matchdata|

        # setup tip data
        text = $1
        title = $3 ? $3 : $1
        tooltip = $4
        tip_obj = ToolTip.new( text, title, tooltip )

        # add the tip to the tooltips array
        section_tooltips << ToolTip.new( text, title, tooltip )

        # return the rendered anchor
        tip_obj.render_anchor

      end
      section_tooltips.each do |tip|
        content << tip.render_tooltip
      end

      return content

    end

  end

  class ToolTip

    attr_reader :text, :title, :tooltip, :id

    # Regex to match on tooltips, they take this pattern:
    # [anchor text]{tip title|the full tooltip}
    #
    # => {
    #   1: text,
    #   2: junk,
    #   3: title,
    #   4: the tooltip
    # }
    def self.pattern
      /\[([^\{]*)\]\{(([^\[]*)\|)?([^\[]*)\}/
    end

    def render_anchor
      "<span class='tip-anchor' data-target='#tooltip-#{@id}' title='#{@tooltip}'>#{@text}</span>"
    end

    def render_tooltip
      "<aside class='tooltip' id='tooltip-#{@id}'><h3 class='subheading'>#{@title}</h3><p class='small'>#{@tooltip}</p></aside>"
    end

    def initialize text, title, tooltip
      @text = text
      @title = title
      @tooltip = Redcarpet::Render::SmartyPants.render(tooltip)
      @id = text.to_slug
    end

  end

end