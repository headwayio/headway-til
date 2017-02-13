class AddDevelopmentAndDesignToChannels < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :development, :boolean
    add_column :channels, :design, :boolean
  end
end
