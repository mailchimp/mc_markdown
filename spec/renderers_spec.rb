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

end