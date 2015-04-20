class ChangeUrlToLink < ActiveRecord::Migration
  def change
    rename_column :posts, :url, :link
  end
end
