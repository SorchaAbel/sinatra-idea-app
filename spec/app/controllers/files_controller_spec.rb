require 'sinatra_helper'

# ----------------------------------------------------------------------------------------------------------------------

RSpec.describe 'FilesController' do
# ---------Clean up-----------------------------------------------------------------------------------------------------
  before(:all) do
    FileUtils.rm_rf(Dir.glob('./files/*'))
  end

  after(:all) do
    FileUtils.rm_rf(Dir.glob('./files/*'))
  end
# ----------------------------------------------------------------------------------------------------------------------

  describe '/files/:filename/download' do
    it 'allows access' do
      FileUtils.touch('./files/test_file')
        get '/files/test_file/download'
        expect(last_response).to be_ok
    end
  end

  describe '/files/:filename' do
    it 'allows access' do
      FileUtils.touch('./files/test_file')
      get '/files/test_file'
      expect(last_response).to be_ok
    end
  end

# ----------------------------------------------------------------------------------------------------------------------

end
