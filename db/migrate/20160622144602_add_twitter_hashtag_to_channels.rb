class AddTwitterHashtagToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :twitter_hashtag, :string
  end
end
