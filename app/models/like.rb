class Like < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe
  
  validates :customer_id, uniqueness: {scope: :recipe_id}
end
