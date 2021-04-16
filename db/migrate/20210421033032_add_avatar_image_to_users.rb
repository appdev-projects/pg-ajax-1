class AddAvatarImageToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar_image, :string, default: "avatar_placeholder.png"
  end
end
