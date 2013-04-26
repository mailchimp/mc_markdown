require 'spec_helper'

describe MCMarkdown::SafeMergeTags do

  it "lets things be emphasized as normal" do
    render_string("*foo*").should == "<p><em>foo</em></p>"
  end

  it "escapes merge tags from emphasisis" do
    render_string("*|MERGE:TAG|*").should == "<p>*|MERGE:TAG|*</p>"
  end

end