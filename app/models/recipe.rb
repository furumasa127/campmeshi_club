class Recipe < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :recipe_details, dependent: :destroy
  accepts_nested_attributes_for :recipe_details, reject_if: :all_blank, allow_destroy: true
  has_many :recipe_steps, dependent: :destroy
  accepts_nested_attributes_for :recipe_steps, reject_if: :all_blank, allow_destroy: true
  has_one_attached :image
  validates :image, presence: true

  def self.search_for(content, method)
    if method == 'perfect'
      Recipe.where(dish_name: content)
    elsif method == 'forward'
      Recipe.where('dish_name LIKE ?', content + '%')
    elsif method == 'backward'
      Recipe.where('dish_name LIKE ?', '%' + content)
    else
      Recipe.where('dish_name LIKE ?', '%' + content + '%')
    end
  end
  
  scope :latest, -> {order(created_at: :desc)}
end
