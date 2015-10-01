get '/download/:filename' do |filename|
  p "inside the loop of downloads"
  send_file "./files/#{filename}", :filename => filename, :type => 'Application/octet-stream'
end
