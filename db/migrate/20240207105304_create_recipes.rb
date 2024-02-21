class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :customer_id, null: false
      t.integer :genre_id
      t.string :dish_name
      t.string :explanation
      t.integer :difficulty
      t.integer :cooking_time
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
