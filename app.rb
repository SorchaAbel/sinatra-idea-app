require "sinatra"
require "sinatra/activerecord"

# Setup load paths
Bundler.require
$: << File.expand_path('../', __FILE__)
Dir['app/**/*.rb'].sort.each { |file| require file }








