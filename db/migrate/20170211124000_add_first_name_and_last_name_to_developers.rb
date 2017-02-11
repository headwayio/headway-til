class AddFirstNameAndLastNameToDevelopers < ActiveRecord::Migration[5.0]
  def change
    add_column :developers, :first_name, :string
    add_column :developers, :last_name, :string
  end
end
