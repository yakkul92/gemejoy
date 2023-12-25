class Review < ApplicationRecord
  
  belongs_to :item
  belongs_to :user
  has_many :favorite_reviews, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  
  validates :comment, presence: { message: "空白は許可されません" }

  def favorited_review_by?(user)
    favorite_reviews.where(user_id: user.id).exists?
  end
  
  def favorite_reviews_count
    favorite_reviews.count
  end
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)} 
  scope :favorite_reviews_count, -> { order(favorite_reviews_count: :desc) }
  
end
