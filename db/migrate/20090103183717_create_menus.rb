class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.references :restaurant
      t.references :meal
      t.references :category
      t.float :price
      t.integer :duration

      t.timestamps
    end
  end

  def self.down
    drop_table :menus
  end
end
