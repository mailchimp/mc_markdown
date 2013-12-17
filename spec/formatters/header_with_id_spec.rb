require 'spec_helper'

describe MCMarkdown::Formatter::HeaderWithID do

  class NoExtensions < Redcarpet::Render::HTML
    include ::MCMarkdown::Formatter::HeaderWithID
  end

  class Subject < MCMarkdown::Html
    include ::MCMarkdown::Formatter::HeaderWithID
  end

  def renderer options={}
    Redcarpet::Markdown.new( Subject.new( options ) )
  end

  it "adds an id to h1 headers" do
    expect( render_string( "# Hello World", renderer ) )
      .to eq("<h1 id='section-hello-world'>Hello World</h1>")
  end

  it "uses the the slug if provided" do
    expect( render_string( "# Hello World", renderer( header_with_id: { slug: "foo" }) ) )
      .to eq "<h1 id='foo-hello-world'>Hello World</h1>"
  end

  it "respects template_tag_headers for the section_id" do
    expect( render_string( "# Hello World", renderer( template_tag_headers: true ) ) )
      .to eq "<h1 id='{{section_id}}'>Hello World</h1>"
  end

  it "doesn't affect headers under h1" do
    expect( render_string( "## Hello World", renderer ) )
      .to eq "<h2>Hello World</h2>"
  end

  context "when given a header level" do

    it "adds slugs to headers in header level" do
      expect( render_string("## Hello World", renderer( header_with_id: { level: 2 } ) ) )
        .to eq "<h2 id='section-hello-world'>Hello World</h2>"
    end

    it "accepts array of header levels" do
      expect( render_string("# Hello\n\n## World", renderer( header_with_id: { level: [1,2] } ) ) )
        .to eq "<h1 id='section-hello'>Hello</h1><h2 id='section-world'>World</h2>"
    end

  end

  context "when extensions aren't present" do

    def no_extension_renderer
      Redcarpet::Markdown.new NoExtensions.new
    end

    it "doesn't raise exceptions" do
      expect{
        render_string("# Hello World", no_extension_renderer)
      }.not_to raise_error
    end

    it "adds IDs to headers" do
      expect( render_string( "# Hello World", no_extension_renderer ) )
        .to eq("<h1 id='section-hello-world'>Hello World</h1>")
    end
  end

end