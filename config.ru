$LOAD_PATH << File.join( Dir.pwd, '/lib' )
$LOAD_PATH << File.join( Dir.pwd, '/app' )

require 'app'
run App.new