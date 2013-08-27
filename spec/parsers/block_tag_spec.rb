require 'spec_helper'

describe MCMarkdown::Parser::BlockTag do
  describe MCMarkdown::Parser::BlockTag::Block do

    let(:block) { MCMarkdown::Parser::BlockTag::Block.new("{{note}}\nfoo bar\n{{/note}}") }

    it "matches on blocks" do
      expect(
        MCMarkdown::Parser::BlockTag::Block.pattern
      ).to match "{{note}}\nfoo bar\n{{/note}}"
    end

    it "recognizes it's type" do
      expect( block.type ).to eq "note"
    end

    it "collects block content under attributes" do
      expect( block.attributes[:content] ).to eq "foo bar"
    end

  end

  describe "#parsed" do

    class TestFormatter < MCMarkdown::Parser::Formatter
      def note attributes={}
        "<div class='note'>#{attributes[:content]}</div>"
      end
    end

    let(:doc) { MCMarkdown::Parser::BlockTag.new( input_string("block_parser","txt"), TestFormatter ) }

    it "parses the block to match the formatter" do
      expect( doc.parsed ).to eq output_string("block_parser", "txt")
    end

  end
end