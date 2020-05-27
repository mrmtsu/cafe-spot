class AddCafememoToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :cafememo, :text
  end
end
