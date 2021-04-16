class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :image
      t.integer :comments_count, default: 0
      t.integer :likes_count, default: 0
      t.text :caption
      t.belongs_to :owner, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end
