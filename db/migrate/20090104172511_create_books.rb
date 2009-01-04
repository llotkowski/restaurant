class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.references :place
      t.references :user
      t.datetime :book_date

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
