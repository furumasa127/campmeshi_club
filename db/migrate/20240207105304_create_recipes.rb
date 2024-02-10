class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :customer_id, null: false
      t.integer :genre_id, null: false
      t.string :dish_name, null: false
      t.string :explanation, null: false
      t.integer :difficulty, null: false
      t.integer :cooking_time, null: false
      t.timestamps
    end
  end
end
