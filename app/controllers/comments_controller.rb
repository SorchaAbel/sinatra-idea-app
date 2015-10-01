post "/comments" do
  @comment = Comment.new(params[:comment])
  p "The comment params are #{params[:comment]}"
  if @comment.save
    redirect "/ideas"
  else
    p "the idea id is #{params[:comment][:idea_id]}"
    @idea = Idea.find(params[:comment][:idea_id])
    @comments = Comment.where(idea_id: params[:id])
    p "The idea is #{@idea.inspect}"
    #@idea.name = @idea.name
    #@idea.description = @idea.description
    erb :show
  end
end
