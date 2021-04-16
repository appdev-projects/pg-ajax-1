class AddPhotosCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :photos_count, :integer, default: 0
  end
end
