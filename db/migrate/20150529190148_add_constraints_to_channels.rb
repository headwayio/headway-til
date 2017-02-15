class AddConstraintsToChannels < ActiveRecord::Migration
  def change
    change_column_null :channels, :created_at, false
    change_column_null :channels, :updated_at, false
  end
end
