class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.string :title
      t.datetime :written_at

      t.timestamps null: false
    end
  end
end
