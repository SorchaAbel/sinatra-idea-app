require 'bundler'

# Setup load paths
Bundler.require
$: << File.expand_path('../', __FILE__)
set :root, Dir['./app']
Dir['./app/**/*.rb'].sort.each { |file| require file }
