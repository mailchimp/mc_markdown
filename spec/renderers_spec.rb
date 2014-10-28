require 'spec_helper'

describe MCMarkdown::Renderers do

  describe "#use" do

    before :each do
      remove_renderer_instances!
    end

    it "creates instances of redcarpet renderers" do
      expect( MCMarkdown::Renderers.use(:base).class ).to eq Redcarpet::Markdown
    end

    it "doesn't recreate instances of initialized renderers" do
      instance = MCMarkdown::Renderers.use(:base)
      expect( MCMarkdown::Renderers.use(:base) ).to eq instance
    end

    it "passes options and uses them as a key" do
      instance = MCMarkdown::Renderers.use :html, no_images: true
      expect( instance.render "![](/foo.png)" ).to eq "<p>![](/foo.png)</p>\n"

      second_instance = MCMarkdown::Renderers.use :html, no_images: false
      expect( second_instance.render "![](/foo.png)" ).to eq "<p><img src=\"/foo.png\" alt=\"\"></p>\n"
    end

  end

  def remove_renderer_instances!
    if MCMarkdown::Renderers.send(:instance_variable_defined?, :@_store)
      MCMarkdown::Renderers.send(:remove_instance_variable, :@_store)
    end
  end

end

describe MCMarkdown do

  describe "#render" do
    it "renders text" do
      expect( MCMarkdown.render "# Hello World" ).to eq "<h1>Hello World</h1>\n"
    end

    it "allows passing options" do
      expect( MCMarkdown.render( "![](/foo.png)", :html, no_images: true ) ).to eq "<p>![](/foo.png)</p>\n"
    end

    it "allows passing extensions" do
      expect( MCMarkdown.render( "==highlight==", :html, extensions: { highlight: true } ) ).to eq "<p><mark>highlight</mark></p>\n"
    end
  end

  describe "#render_with_frontmatter" do
    it "renders text" do
      frontmatter, rendered = MCMarkdown.render_with_frontmatter "# Hello World"

      expect( frontmatter ).to eq({})
      expect( rendered ).to eq "<h1>Hello World</h1>\n"
    end

    it "allows passing options" do
      frontmatter, rendered = MCMarkdown.render_with_frontmatter( "![](/foo.png)", :html, no_images: true )

      expect( frontmatter ).to eq({})
      expect( rendered ).to eq "<p>![](/foo.png)</p>\n"
    end

    it "allows passing extensions" do
      frontmatter, rendered = MCMarkdown.render_with_frontmatter( "==highlight==", :html, extensions: { highlight: true } )

      expect( frontmatter ).to eq({})
      expect( rendered ).to eq "<p><mark>highlight</mark></p>\n"
    end

    it "returns frontmatter as hash" do
      frontmatter, rendered = MCMarkdown.render_with_frontmatter "---\nfoo: bar\n---\n\n# Hello World"

      expect( frontmatter ).to eq "foo" => 'bar'
      expect( rendered ).to eq "<h1>Hello World</h1>\n"
    end

    it "handles more 'complex' frontmatter types" do
      content = <<-EOF
---
foo: bar
an_array:
  - one
  - two
a_hash:
  three: four
  five: six
long_content: |
  line one

  line two
---

# Hello World
EOF

      frontmatter, rendered = MCMarkdown.render_with_frontmatter content

      expect( frontmatter ).to eq "foo" => "bar",
                                  "an_array" => ["one","two"],
                                  "a_hash" => { "three" => "four",
                                                "five" => "six" },
                                  "long_content" => "line one\n\nline two\n"
    end

    it "ignores injection of unkown ruby types" do
      content = <<-EOF
---
--- !ruby/hash:ClassBuilder
foo: bar
---

# Hello World
EOF

      frontmatter, rendered = MCMarkdown.render_with_frontmatter content

      expect( frontmatter ).to eq "foo" => "bar"
      expect( rendered ).to eq "<h1>Hello World</h1>\n"
    end
  end

end
