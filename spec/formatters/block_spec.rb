require 'spec_helper'

describe MCMarkdown::Formatter::Blocks do

  it "generates a notes block" do
    test_fixture '/base/note'
  end

  it "generates a callout block" do
    test_fixture '/base/callout'
  end

end