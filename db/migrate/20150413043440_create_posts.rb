class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :url
      t.references :user, index: true
      t.string :timestamps

      t.timestamps
    end
  end
end
