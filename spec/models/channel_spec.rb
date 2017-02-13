require 'rails_helper'

describe Channel do
  it 'should have a valid factory' do
    channel = FactoryGirl.build(:channel)
    expect(channel).to be_valid
  end

  describe '#parent' do
    it 'accepts a parent channel' do
      parent = create(:channel, name: 'design')

      channel1  = create(:channel, name: 'sketch', parent: parent)
      channel2  = create(:channel, name: 'css', parent: parent)

      post1 = build(:post)
      post2 = build(:post)
      post3 = build(:post)

      channel1.posts << post1
      channel2.posts << post2
      channel2.posts << post3

      parent.reload
      channel1.reload
      channel2.reload

      expect(channel1.parent).to eql(parent)
      expect(channel2.parent).to eql(parent)
      expect(parent.channels).to match_array([channel1, channel2])

      expect(channel1.posts).to match_array([post1])
      expect(channel2.posts).to match_array([post2, post3])
      expect(parent.child_posts).to match_array([post1, post2, post3])
    end
  end
end
