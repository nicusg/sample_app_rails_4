class Votes < ActiveRecord::Migration
  def change
    create_table :votes, :id => false do |t|
      t.integer :user_id
      t.integer :micropost_id
    end
  end
end
