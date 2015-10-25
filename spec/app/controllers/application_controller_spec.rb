require 'sinatra_helper'

# ----------------------------------------------------------------------------------------------------------------------

RSpec.describe 'ApplicationController' do

  describe 'get /about' do
    it 'allows access' do
      get '/about'
      expect(last_response).to be_ok
    end
  end

# ----------------------------------------------------------------------------------------------------------------------

end
