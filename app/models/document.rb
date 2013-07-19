require 'uuidtools'

class Document < Sequel::Model(:documents)

  def before_create
    self.slug = generate_slug
    super
  end

  # id
  # @returns [Integer]

  # slug
  # @returns [String]

  # name
  # @returns [String]

  # content
  # @returns [String]

  # @returns [String] content as html
  def to_html
    App::MD.render( content )
  end

  private

    def generate_slug
      UUIDTools::UUID.timestamp_create().to_s
    end
end