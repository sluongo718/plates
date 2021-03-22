class CreatePlates < ActiveRecord::Migration[5.2]
  def change
    create_table :plates do |t|
      t.string :name
      t.string :plate_type
      t.string :ingredients
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
