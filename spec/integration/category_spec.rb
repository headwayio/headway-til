require 'rails_helper'

describe 'Channel categories', type: :feature do
  describe 'development' do
    it 'displays development posts' do
      channel1 = create(:channel, :development, name: 'Text Editor')
      channel2 = create(:channel, :design, name: 'Sketch')

      post1 = create(:post, title: 'Vim or nothing')
      post2 = create(:post, title: 'Colors and shapes')

      post1.channels << channel1
      post2.channels << channel2

      visit '/'

      click_link 'Development'

      expect(page).to have_content('Vim or nothing')
      expect(page).to have_content('Text Editor')
      expect(page).not_to have_content('Colors and shapes')
    end
  end

  describe 'design' do
    it 'displays design posts' do
      channel1 = create(:channel, :development, name: 'Text Editor')
      channel2 = create(:channel, :design, name: 'Sketch')

      post1 = create(:post, title: 'Vim or nothing')
      post2 = create(:post, title: 'Colors and shapes')

      post1.channels << channel1
      post2.channels << channel2

      visit '/'

      click_link 'Design'

      expect(page).to have_content('Sketch')
      expect(page).to have_content('Colors and shapes')
      expect(page).not_to have_content('Vim or nothing')
    end
  end

  describe 'all' do
    it 'displays all posts' do
      channel1 = create(:channel, :development, name: 'Text Editor')
      channel2 = create(:channel, :design, name: 'Sketch')

      post1 = create(:post, title: 'Vim or nothing')
      post2 = create(:post, title: 'Colors and shapes')

      post1.channels << channel1
      post2.channels << channel2

      visit '/'

      click_link 'All'

      expect(page).to have_content('Sketch')
      expect(page).to have_content('Colors and shapes')
      expect(page).to have_content('Vim or nothing')
      expect(page).to have_content('Text Editor')
    end
  end
end
