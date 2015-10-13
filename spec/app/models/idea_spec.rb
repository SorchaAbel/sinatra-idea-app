require 'spec_helper'
describe Idea do
  it 'should not save without name' do
    idea = Idea.new
    expect(idea).to_not be_valid
  end
end