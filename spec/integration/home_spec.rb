require 'rails_helper'

describe 'Home', type: :feature do
  describe 'visitor' do
    it 'displays posts' do
      channel1 = create(:channel, name: 'Development')
      channel2 = create(:channel, name: 'Design')

      create(:post, title: 'Vim or nothing', channel: channel1)
      create(:post, title: 'Colors and shapes', channel: channel2)

      visit '/'

      expect(page).to have_content('Vim or nothing')
      expect(page).to have_content('Colors and shapes')
    end
  end
end
