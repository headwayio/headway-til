class AddParentIdToChannels < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :parent_id, :integer
    add_index :channels, :parent_id
  end
end
