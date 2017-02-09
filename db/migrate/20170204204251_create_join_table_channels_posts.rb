class CreateJoinTableChannelsPosts < ActiveRecord::Migration[5.0]
  def change
    create_join_table :channels, :posts do |t|
      t.index [:channel_id, :post_id]
    end
  end
end
