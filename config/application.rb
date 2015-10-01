require 'bundler'

# Setup load paths
Bundler.require
$: << File.expand_path('../', __FILE__)
set :root, Dir['./app']
set :public_folder, Proc.new { File.join(root, 'assets') }
Dir['./app/**/*.rb'].sort.each { |file| require file }
