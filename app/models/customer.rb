class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id",dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_one_attached :image
  validate

  def follow(customer)
    active_relationships.create(followed_id: customer.id)
  end

  def unfollow(customer)
    active_relationships.find_by(followed_id: customer.id).destroy
  end

  def following?(customer)
    followings.include?(customer)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲスト"
      customer.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/guest.jpg"), filename:"guest.jpg")
    end
  end



  scope :latest, -> {order(created_at: :desc)}
    validates :image, presence: true, on: :publish
    validates :dish_name, presence: true, on: :publish
    validates :explanation, presence: true, on: :publish
    validates :difficulty, presence: true, on: :publish
    validates :cooking_time, presence: true, on: :publish
    validates :genre_id, presence: true, on: :publish
end
