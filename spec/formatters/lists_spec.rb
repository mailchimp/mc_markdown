require 'spec_helper'

describe MCMarkdown::Formatter::Lists do

  it "generates unordered lists" do
    test_fixture '/base/lists/ul'
  end

  it "generates orderd lists" do
    test_fixture '/base/lists/ol'
  end

  it "generate definition lists" do
    test_fixture '/base/lists/dl'
  end

end