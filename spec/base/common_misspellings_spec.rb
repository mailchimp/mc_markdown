require 'spec_helper'

describe MCMarkdown::CommonMisspellings do

  it "filters out misspellings" do
    render_string("one&ldqou;&rdqou;&rsqou;").should == "<p>one&ldquo;&rdquo;&rsquo;</p>"
  end

end