require 'rails_helper'

describe Channel do
  it 'should have a valid factory' do
    channel = FactoryGirl.build(:channel)
    expect(channel).to be_valid
  end

  describe '#parent' do
    it 'accepts a parent channel' do
      parent = create(:channel, name: 'design')
      child  = create(:channel, name: 'sketch', parent: parent)
      expect(child.parent).to be(parent)
      expect(parent.channels).to match_array([child])
    end
  end
end
