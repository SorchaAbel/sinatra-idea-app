require 'sinatra_helper'

# ----------------------------------------------------------------------------------------------------------------------

RSpec.describe 'IdeasController' do
# ---------Clean up-----------------------------------------------------------------------------------------------------
  before(:all) do
    Idea.delete_all
    FileUtils.rm_rf(Dir.glob('./files/*'))
  end

  after(:all) do
    Idea.delete_all
    FileUtils.rm_rf(Dir.glob('./files/*'))
  end
# ----------------------------------------------------------------------------------------------------------------------

  let(:valid_params) {
    {
      idea: {
        name:        'name',
        description: 'description',
        picture:     Rack::Test::UploadedFile.new(__FILE__)
      }
    }
  }
  let(:empty_params) { {} }

  describe 'get / and /ideas' do
    it 'allows access' do
      %w(/ /ideas).each do |path|
        get path
        expect(last_response).to be_ok
      end
    end
  end

  describe 'get /new /ideas/new' do
    it 'allows access' do
      %w(/new /ideas/new).each do |path|
        get path
        expect(last_response).to be_ok
      end
    end
  end

  describe 'post /ideas' do
    context 'with invalid params' do
      it 'responds with an error' do
        post '/ideas', empty_params
        expect(last_response).to_not be_ok
        expect(last_response.status).to eq(500)
        expect(Idea.count).to eq(0)
      end
    end

    context 'with valid params' do
      after(:each) do
        Idea.delete_all
      end

      it 'creates the post' do
        post '/ideas', valid_params
        expect(last_response.status).to eq(302)
        expect(Idea.count).to eq(1)
        expect(Idea.last.name).to eq(valid_params[:idea][:name])
        expect(Idea.last.description).to eq(valid_params[:idea][:description])
        expect(Idea.last.picture.include?(valid_params[:idea][:picture].original_filename)).to be_truthy
      end
    end

  end

  describe 'get /ideas/:id' do
    it 'allows access' do
      post '/ideas', valid_params
      get "/ideas/#{Idea.last.id}"
      expect(last_response).to be_ok
    end
  end

  describe 'get /ideas/:id/edit' do
    it 'allows access' do
      post '/ideas', valid_params
      get "/ideas/#{Idea.last.id}/edit"
      expect(last_response).to be_ok
    end
  end

  describe 'put /ideas/:id' do
    it 'allows access' do
      post '/ideas', valid_params
      put "/ideas/#{Idea.last.id}", valid_params
      expect(last_response.status).to eq(302)
    end
  end

  describe 'delete /ideas/:id' do
    it 'allows access' do
      post '/ideas', valid_params
      delete "/ideas/#{Idea.last.id}"
      expect(last_response.status).to eq(302)
    end
  end

# ----------------------------------------------------------------------------------------------------------------------

end
