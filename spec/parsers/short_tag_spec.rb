require 'spec_helper'

describe MCMarkdown::Parser::ShortTag do

  describe MCMarkdown::Parser::ShortTag::Tag do

    it "determines type insensitive to whitespace" do
      [ "{{video}}", "{{ video}}", "{{video }}", "{{ video }}" ].each do |tag|

        expect( MCMarkdown::Parser::ShortTag::Tag.new(tag).type ).to eq 'video'

      end
    end

    context "tag without attributes" do

      let(:tag) { MCMarkdown::Parser::ShortTag::Tag.new('{{video}}') }

      it "determines the correct type" do
        expect( tag.type ).to eq 'video'
      end

      it "returns an empty array of attributes" do
        expect( tag.attributes ).to match_array []
      end

    end

    context "tag with attributes" do

      let(:tag) { MCMarkdown::Parser::ShortTag::Tag.new('{{video width="500" height="400"}}') }

      it "determines the correct type" do
        expect( tag.type ).to eq 'video'
      end

      it "returns the correct attributes" do
        expect( tag.attributes ).to match_array [{"width"=>"500"},{"height"=>"400"}]
      end

    end


  end

  describe "#parsed" do

    content = %Q{

# Hello World

{{video width="500" height="400"}}

}

    class TestFormatter
      include MCMarkdown::Parser::Formatter

      def video attributes=[]
        "woot"
      end
    end

    let(:doc) { MCMarkdown::Parser::ShortTag.new( content, TestFormatter ) }

    it "parses tags out to match what the formatter returns" do
      expect( doc.parsed ).to eq %Q{

# Hello World

woot

}
    end

  end

end