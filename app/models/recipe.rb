class Recipe < ApplicationRecord
  belongs_to :customer
  belongs_to :genre, optional: true
  has_many :recipe_details, dependent: :destroy
  accepts_nested_attributes_for :recipe_details, reject_if: :all_blank, allow_destroy: true
  has_many :recipe_steps, dependent: :destroy
  accepts_nested_attributes_for :recipe_steps, reject_if: :all_blank, allow_destroy: true
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum status: { published: 0, draft: 1, unpublished: 2 }

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

  def liked_by?(customer)
    likes.exists?(customer_id: customer.id)
  end

  scope :latest, -> {order(created_at: :desc)}

  with_options if: :published? do
    validates :image, presence: true
    validates :dish_name, presence: true
    validates :explanation, presence: true
    validates :difficulty, presence: true
    validates :cooking_time, presence: true
    validates :genre_id, presence: true
  end
  
  validates_associated :recipe_details
  validates :recipe_details, presence: true
  with_options presence: true do
    #validates :ingredient, presence: true
#    validates :quantity, presence: true, numericality: { allow_blank: true}
  end
  
  validates_associated :recipe_steps
  validates :recipe_steps, presence: true
end



