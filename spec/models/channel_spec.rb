require 'rails_helper'

describe Channel do
  it 'should have a valid factory' do
    channel = FactoryGirl.build(:channel)
    expect(channel).to be_valid
  end

  it 'returns development related channels' do
    channel1 = create(:channel, :development)
    create(:channel, :design)

    channels = described_class.development

    expect(channels).to match_array([channel1])
  end

  it 'returns design related channels' do
    channel1 = create(:channel, :design)
    create(:channel, :development)

    channels = described_class.design

    expect(channels).to match_array([channel1])
  end
end
