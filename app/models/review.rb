class Review < ApplicationRecord
  
  belongs_to :item
  belongs_to :user
  has_many :favorite_reviews, dependent: :destroy

  def favorited_review_by?(user)
    favorite_reviews.where(user_id: user.id).exists?
  end
  
  def favorite_reviews_count
    favorite_reviews.count
  end
  
end
