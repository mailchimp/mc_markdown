# Add ./lib to the load path
$LOAD_PATH << File.join( Dir.pwd, '/lib' )

require 'pry'
require 'mc_markdown'

BASE = Redcarpet::Markdown.new( MCMarkdown::Base )
LEGAL = Redcarpet::Markdown.new( MCMarkdown::Legal )

def input_string path, ext='md'
  path = File.join( __dir__, "fixtures", "#{path}-input.#{ext}" )
  return IO.read( path )
end

def output_string path, ext='html'
  path = File.join( __dir__, "fixtures", "#{path}-output.#{ext}" )
  return IO.read( path )
end

def render_string str, renderer=BASE
  renderer.render(str).strip
end

def test_fixture path, renderer=BASE
  expect( render_string( input_string(path) ) ).to eq output_string(path)
end

describe 'spec_helper' do

  it "has BASE defined" do
    BASE.class.should == Redcarpet::Markdown
  end

  it "has LEGAL defined" do
    LEGAL.class.should == Redcarpet::Markdown
  end

end
