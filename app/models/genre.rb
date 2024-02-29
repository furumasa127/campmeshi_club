class Genre < ApplicationRecord
  has_many :recipes, dependent: :destroy
  
  enum payment_method: { credit_card: 0, transfer: 1 }
end
