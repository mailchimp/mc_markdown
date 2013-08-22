module MCMarkdown
  module Renderers
    class << self

      def use renderer_class
        fetch(renderer_class)
      end

      private

        def store
          @_store ||= {}
        end

        def fetch renderer_class
          store.fetch(renderer_class) { add(renderer_class) }
        end

        def add renderer_class
          store[renderer_class] = Redcarpet::Markdown.new(
            ::MCMarkdown.const_get(renderer_class.to_s.capitalize)
          )
        end

    end
  end

  def self.render input, renderer=:base
    Renderers.use(renderer).render(input)
  end
end