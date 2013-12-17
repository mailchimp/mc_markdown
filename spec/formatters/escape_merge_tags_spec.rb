require 'spec_helper'

describe MCMarkdown::Formatter::EscapeMergeTags do

  it "lets things be emphasized as normal" do
    render_string("*foo*").should == "<p><em>foo</em></p>"
  end

  it "escapes merge tags from emphasisis" do
    render_string("*|MERGE:TAG|*").should == "<p>*|MERGE:TAG|*</p>"
    render_string("*|MERGE:TAG:AGAIN|*").should == "<p>*|MERGE:TAG:AGAIN|*</p>"
  end

  it "handles merge tags with underscores and other formating" do
    render_string("*|MERGE_TAG_FOO|*").should == "<p>*|MERGE_TAG_FOO|*</p>"
    render_string("*|MERGE_TAG_FOO_BAR|*").should == "<p>*|MERGE_TAG_FOO_BAR|*</p>"
    render_string("*|MERGE_TAG|* and other_text").should == "<p>*|MERGE_TAG|* and other_text</p>"
  end

  it "handles merge tags with arrays" do
    render_string("*|FEEDITEMS:[$count=n,$category=xx]|*").should == "<p>*|FEEDITEMS:[$count=n,$category=xx]|*</p>"
  end

end