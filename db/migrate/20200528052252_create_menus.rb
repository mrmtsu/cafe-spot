class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :name
      t.integer :post_id
      t.string :price
      t.timestamps
    end
    add_index :menus, :post_id
  end
end
