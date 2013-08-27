module MCMarkdown
  module Formatter

    module Wistia

      IFRAME_PATTERN = /\{\{video(.*)\}\}/

      def preprocess doc

        defaults = {
          version: "v1",
          video_width: 600,
          video_height: 400,
          controls_visible_on_load: true
        }

        doc.gsub!(IFRAME_PATTERN) do |video|
          params_array = video.match(IFRAME_PATTERN).to_a.last.split(/=|\s/).delete_if {|v| v == "" }

          params = {}
          html_params = []

          params_array.each_slice(2) do |batch|
            if batch[0] && batch[1]
              params[batch[0].to_sym] = batch[1].gsub( /'|"/, '' )
            end
          end
          wistia_id = params.delete(:id)

          # Build iframe if wistia_id is present in tag
          if wistia_id
            options = defaults.merge(params)

            iframe = "<iframe src='http://fast.wistia.com/embed/iframe/#{wistia_id}"
            options.each_with_index do |(attr, value), idx|
              # convert attribute names to camelCase
              string = attr.to_s.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join

              # append to iframe tag
              glue = idx == 0 ? "?" : "&"
              iframe += "#{glue}#{string}=#{value}"
            end

            { width: params[:video_width], height: params[:video_height] }.each do |k,v|
              html_params << ["#{k}='#{v}'"]
            end

            "#{iframe}' allowtransparency='true' frameborder='0' scrolling='no' class='wistia_embed' name='wistia_embed' #{html_params.join(' ')}></iframe>"
          else
            ""
          end
        end

        if defined?(super)
          return super(doc)
        else
          return doc
        end
      end

    end

  end
end