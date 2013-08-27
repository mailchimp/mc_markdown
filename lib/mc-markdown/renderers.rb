module MCMarkdown
  module Renderers
    class << self

      def use renderer_class, options={}
        fetch( { class: renderer_class, extensions: options.delete(:extensions), options: options } )
      end

      private

        def store
          @_store ||= {}
        end

        def fetch renderer_key
          store.fetch(renderer_key) { add(renderer_key) }
        end

        def add renderer_key
          extensions = renderer_key[:extensions] || {}

          store[renderer_key] = Redcarpet::Markdown.new(
            ::MCMarkdown.const_get( renderer_key[:class].to_s.capitalize ).new( renderer_key[:options] ),
            extensions
          )
        end

    end
  end

  def self.render input, renderer=:base, options={}
    Renderers.use(renderer, options).render(input)
  end
end