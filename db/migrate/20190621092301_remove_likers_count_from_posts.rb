class RemoveLikersCountFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :likers_count, :integer
  end
end
