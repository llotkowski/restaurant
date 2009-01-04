class CreateMeals < ActiveRecord::Migration
  def self.up
    create_table :meals do |t|
      t.string :name
      t.text :desc
      t.text :elements
      t.float :amount
      t.string :unit

      t.timestamps
    end
  end

  def self.down
    drop_table :meals
  end
end
