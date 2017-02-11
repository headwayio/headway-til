class AddTitleToDevelopers < ActiveRecord::Migration[5.0]
  def change
    add_column :developers, :title, :string
  end
end
