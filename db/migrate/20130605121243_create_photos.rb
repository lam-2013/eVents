class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    # index to help us retrieve all the photos associated with a given user in reverse order
    add_index :photos, [:user_id, :created_at]
  end
end
