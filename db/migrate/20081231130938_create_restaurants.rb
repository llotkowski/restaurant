class CreateRestaurants < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.string :name
      t.string :street
      t.string :number
      t.string :city
      t.text :desc
      t.float :longitude
      t.float :latitude
      t.float :zoom
      t.timestamps
    end
  end

  def self.down
    drop_table :restaurants
  end
end
