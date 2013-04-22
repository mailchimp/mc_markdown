class Document < Sequel::Model(:documents)

  # id
  # @returns [Integer]

  # name
  # @returns [String]

  # content
  # @returns [String]

  # @returns [String] content as html
  def to_html
    App::MD.render( content )
  end

end