class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :zip_code,  :null => false
      t.float  :latitude,  :null => false
      t.float  :longitude, :null => false

      t.timestamps :null => false
    end

      add_index :locations, :zip_code, :unique => true
  end
end
