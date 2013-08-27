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

      it "returns an empty hash of attributes" do
        expect( tag.attributes ).to eq( {} )
      end
    end

    context "tag with attributes" do
      let(:tag) { MCMarkdown::Parser::ShortTag::Tag.new('{{video width="500" height="400"}}') }

      it "determines the correct type" do
        expect( tag.type ).to eq 'video'
      end

      it "returns the correct attributes" do
        expect( tag.attributes ).to eq({ width: "500", height: "400"})
      end
    end


  end

  describe "#parsed" do

    class TestFormatter < MCMarkdown::Parser::Formatter
      def video attributes=[]
        "woot"
      end
    end

    let(:doc) { MCMarkdown::Parser::ShortTag.new( input_string("parser","txt"), TestFormatter ) }

    it "parses tags out to match what the formatter returns" do
      expect( doc.parsed ).to eq output_string("parser","txt")
    end

  end

end