require 'sinatra_helper'

# ----------------------------------------------------------------------------------------------------------------------

RSpec.describe 'CommentsController' do
  # ---------Clean up-----------------------------------------------------------------------------------------------------
  before(:all) do
    Idea.delete_all
    Comment.delete_all
  end

  after(:all) do
    Idea.delete_all
    Comment.delete_all
  end
# ----------------------------------------------------------------------------------------------------------------------

  describe 'post /comments' do

    context 'with invalid params' do
      let(:empty_params) { {} }
      it 'responds with an error' do
        post '/comments', empty_params
        expect(last_response).to_not be_ok
        expect(last_response.status).to eq(500)
        expect(Comment.count).to eq(0)
      end
    end

    context 'with valid params' do
      let(:idea) { Idea.create(name: 'name', description: 'descriptions')}
      let(:valid_params) {
        {
          comment: {
            user_name: 'user_name',
            body:     'body',
            idea_id:  idea.id
          }
        }
      }

      it 'creates the post' do
        post '/comments', valid_params
        puts last_response.inspect
        expect(last_response.status).to eq(302)
        expect(Comment.count).to eq(1)
        expect(Comment.last.user_name).to eq(valid_params[:comment][:user_name])
        expect(Comment.last.body).to eq(valid_params[:comment][:body])
        expect(Comment.last.idea_id).to eq(valid_params[:comment][:idea_id])
      end
    end

  end

  # ----------------------------------------------------------------------------------------------------------------------

end
