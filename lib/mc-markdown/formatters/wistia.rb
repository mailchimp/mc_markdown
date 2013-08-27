module MCMarkdown
  module Formatter
    module Wistia

      def preprocess doc
        doc = Parser::ShortTag.new(doc, WistiaFormatter).parsed

        if defined?(super)
          return super(doc)
        else
          return doc
        end
      end

      class WistiaFormatter < Parser::Formatter

        def video attributes={}
          wistia_id = attributes.delete(:id)
          options = defaults.merge(attributes)

          query_params = options.map do |attr,value|
            # camel case attribute names
            camel_case = attr.to_s.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
            "#{camel_case}=#{value}"
          end

          html_params = {
            src: "http://fast.wistia.com/embed/iframe/#{wistia_id}?#{query_params.join('&')}",
            allowtransparency: 'true',
            frameborder: '0',
            scrolling: 'no',
            class: 'wistia_embed',
            name: 'wistia_embed',
            width: options[:video_width],
            height: options[:video_height]
          }

          if wistia_id
            "<iframe #{render_params( html_params )}></iframe>"
          else
            ""
          end
        end

        private

          def defaults
            {
              version: "v1",
              video_width: 600,
              video_height: 400,
              controls_visible_on_load: true
            }
          end

          def render_params params
            params.map { |attr, value| "#{attr}='#{value}'" }.join(' ')
          end

      end

    end
  end
end