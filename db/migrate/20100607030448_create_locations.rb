class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.integer :zip_code
      t.timestamps
    end
  end
  
  def self.down
    drop_table :locations
  end
end