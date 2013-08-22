require 'spec_helper'

describe MCMarkdown::Formatter::HeaderWithID do

  class Subject < Redcarpet::Render::HTML
    include ::MCMarkdown::Formatter::HeaderWithID
  end

  def renderer options={}
    Redcarpet::Markdown.new( Subject.new( options ) )
  end

  it "adds an id to h1 headers" do
    expect( render_string( "# Hello World", renderer ) ).to eq("<h1 id='section-hello-world'>Hello World</h1>")
  end

  it "uses the the slug if provided" do
    expect( render_string( "# Hello World", renderer( slug: "foo" ) ) ).to eq "<h1 id='foo-hello-world'>Hello World</h1>"
  end

  it "respects template_tag_headers for the section_id" do
    expect( render_string( "# Hello World", renderer( template_tag_headers: true ) ) )
      .to eq "<h1 id='{{section_id}}'>Hello World</h1>"
  end

  it "doesn't affect headers under h1" do
    expect( render_string( "## Hello World", renderer ) ).to eq "<h2>Hello World</h2>"
  end

end