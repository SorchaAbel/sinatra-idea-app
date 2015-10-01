require "sinatra"
require "sinatra/activerecord"

class Idea < ActiveRecord::Base
    has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :idea
  validates_presence_of :body, :user_name
end

get '/ideas' do
    @ideas = Idea.all
    erb :index
end

get '/' do
    @ideas = Idea.all
    erb :index
end

get "/new" do
    @title = "New Idea"
    @idea = Idea.new
    erb :new
end

post "/ideas" do
    @idea = Idea.new(params[:idea])
    p "testing #{@idea.picture}"
    @filename = params[:idea][:picture][:filename]
    @idea.picture = @filename
    file = params[:idea][:picture][:tempfile]
    p "The filename is #{@filename}"

    File.open("./files/#{@filename}", 'wb') do |f|
        f.write(file.read)
    end
    if @idea.save
        redirect "/ideas"
    else
        erb :new
    end
end

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

get '/download/:filename' do |filename|
    p "inside the loop of downloads"
    send_file "./files/#{filename}", :filename => filename, :type => 'Application/octet-stream'
end

# Get the individual page of the post with this ID.
get "/ideas/:id" do
    @idea = Idea.find(params[:id])
    @comments = Comment.where(idea_id: params[:id])
    @comment = @idea.comments.build
    erb :show
end

get "/ideas/:id/edit" do
    @idea = Idea.find(params[:id])
    erb :edit
end

# The Edit Post form sends a PUT request (modifying data) here.
# If the idea is updated successfully, redirect to it. Otherwise,
# render the edit form again with the failed @idea object still in memory
# so they can retry.
put "/ideas/:id" do
    p params
    if params[:idea].try(:[], :picture)
        file      = params[:idea][:picture][:tempfile]
        @filename = params[:idea][:picture][:filename]
    end

    @idea = Idea.find(params[:id])

    if @idea.update_attributes(params[:idea])
        if @filename
            @idea.picture = @filename
            p "the sorcha filename is #{@filename}"
            @idea.save
            File.open("./files/#{@filename}", 'wb') do |f|
                f.write(file.read)
            end
        end
        redirect "/ideas/#{@idea.id}"
    else
        erb :edit
    end
end

delete "/ideas/:id" do
    @idea = Idea.find(params[:id]).destroy
    redirect "/ideas"
end

get "/about" do
    erb :about
end
helpers do
    def delete_idea_button(idea_id)
        erb :_delete_idea_button, locals: { idea_id: idea_id}
    end
end

