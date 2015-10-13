require 'bundler'

# Setup load paths
Bundler.require

$: << File.expand_path('../', __FILE__)

Dir['./app/**/*.rb'].sort.each { |file| require file }

# sinatra configuration
set :root, Dir['./app']
set :public_folder, Proc.new { File.join(root, 'assets') }
set :erb, :layout => :'layouts/application'
