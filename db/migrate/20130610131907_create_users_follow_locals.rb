class CreateUsersFollowLocals < ActiveRecord::Migration
  def change
    create_table :users_follow_locals do |t|

      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    # indexes
    add_index :users_follow_locals, :follower_id
    add_index :users_follow_locals, :followed_id
    # a user cannot follow another user more than one time...
    add_index :users_follow_locals, [ :follower_id, :followed_id ], unique: true
  end
end
