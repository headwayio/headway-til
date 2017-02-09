class AddAvatarToDevelopers < ActiveRecord::Migration[5.0]
  def change
    add_column :developers, :avatar, :string
  end
end
