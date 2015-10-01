post '/comments' do
  @comment = Comment.new(params[:comment])
  p "The comment params are #{params[:comment]}"
  if @comment.save
    redirect '/ideas'
  else
    @flash = {errors: [{comment: 'could not save comment'}]}
    erb :show
  end
end
