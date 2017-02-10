class AddIndexToVotes < ActiveRecord::Migration
  def change
    add_index(:votes, [:user_id, :micropost_id], unique: true)
  end
end
