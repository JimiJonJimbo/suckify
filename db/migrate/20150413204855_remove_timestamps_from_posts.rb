class RemoveTimestampsFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :timestamps, :string
  end
end
