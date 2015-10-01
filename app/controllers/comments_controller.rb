post '/comments' do
  @comment = Comment.new(params[:comment])
  p "The comment params are #{params[:comment]}"
  if @comment.save
    redirect '/ideas'
  else
    @idea = Idea.find(params[:comment][:idea_id])
    @flash = {errors: [{comment: 'could not save comment'}]}
    erb :'ideas/show'
  end
end
