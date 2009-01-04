class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.references :restaurant
      t.integer :x
      t.integer :y
      t.integer :number

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
