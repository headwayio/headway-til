require 'rails_helper'

describe 'Home', type: :feature do
  describe 'visitor' do
    it 'displays posts' do
      channel1 = create(:channel, name: 'Text Editor')
      channel2 = create(:channel, name: 'Sketch')

      post1 = create(:post, title: 'Vim or nothing')
      post2 = create(:post, title: 'Colors and shapes')

      post1.channels << channel1
      post2.channels << channel2

      visit '/'

      expect(page).to have_content('Vim or nothing')
      expect(page).to have_content('text editor')
      expect(page).to have_content('sketch')
    end
  end
end
