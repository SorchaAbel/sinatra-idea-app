require 'sinatra_helper'

# ----------------------------------------------------------------------------------------------------------------------

RSpec.describe Comment do

  describe '#initialize' do

    it 'without user_name' do
      expect(described_class.new(body: 'body', user_name: nil)).to_not be_valid
    end

    it 'without body' do
      expect(described_class.new(body: nil, user_name: 'user_name')).to_not be_valid
    end

    it 'with valid' do
      expect(described_class.new(body: 'body', user_name: 'user_name')).to be_valid
    end

  end

# ----------------------------------------------------------------------------------------------------------------------

end
