require 'spec_helper'

describe MCMarkdown::Links do

  it "generates a plain link" do
    render_string( "[text](/path)" ).should == "<p><a href='/path'>text</a></p>"
  end

  it "generates a link with a class" do
    render_string( "[text {class}](/path)" ).should == "<p><a href='/path' class='class'>text</a></p>"
  end

  it "generates a link with a target" do
    render_string( "[text _blank](/path)" ).should == "<p><a href='/path' target='_blank'>text</a></p>"
  end

  it "generates a link with a target and a class" do
    render_string( "[text {class} _blank](/path)" ).should == "<p><a href='/path' class='class' target='_blank'>text</a></p>"
  end

end