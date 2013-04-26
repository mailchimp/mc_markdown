# Add ./lib to the load path
$LOAD_PATH << File.join( Dir.pwd, '/lib' )

require 'mc-markdown'

BASE = Redcarpet::Markdown.new( MCMarkdown::Base )
LEGAL = Redcarpet::Markdown.new( MCMarkdown::Legal )

def input_string path
  path = File.join( __dir__, "fixtures", "#{path}-input.md" )
  return IO.read( path )
end

def output_string path
  path = File.join( __dir__, "fixtures", "#{path}-output.html" )
  return IO.read( path )
end

def test_fixture path, renderer=BASE
  renderer.render( input_string(path) ).should == output_string(path)
end

describe 'spec_helper' do

  it "has BASE defined" do
    BASE.class.should == Redcarpet::Markdown
  end

  it "has LEGAL defined" do
    LEGAL.class.should == Redcarpet::Markdown
  end

end