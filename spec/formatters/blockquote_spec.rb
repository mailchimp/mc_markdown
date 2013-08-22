require 'spec_helper'

describe MCMarkdown::Formatter::Blockquote do

  it "splits blockquotes into two if there is a space between them" do
    test_fixture "base/blockquote"
  end

end