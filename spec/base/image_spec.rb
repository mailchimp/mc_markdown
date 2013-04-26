require 'spec_helper'

describe MCMarkdown::Image do

  it "generates an image with no alt text" do
    BASE.render('![](/path/image.jpg)').strip.should == "<p><img src='/path/image.jpg' alt='' /></p>"
  end

  it "generates an image with alt text" do
    BASE.render('![alt text](/path/image.jpg)').strip.should == "<p><img src='/path/image.jpg' alt='alt text' /></p>"
  end

  it "generates a figcaption when passed a title" do
    BASE.render('![alt text](/path/image.jpg "the caption")').strip.should == "<p><figure class='img'><img src='/path/image.jpg' alt='alt text' /><figcaption><p>the caption</p></figcaption></figure></p>"
  end


end