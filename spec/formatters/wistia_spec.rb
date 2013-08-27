require 'spec_helper'

describe MCMarkdown::Formatter::Wistia do

  it "generates a wistia iframe embed" do
    test_fixture '/base/wistia'
  end

end