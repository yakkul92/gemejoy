class Review < ApplicationRecord
  
  belongs_to :item
  belongs_to :user
  has_many :favorite_reviews, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  
  validates :comment, presence: { message: "空白は許可されません" }
  
  # 特定のユーザーがレビューをお気に入りにしているかどうかを確認するメソッド
  def favorited_review_by?(user)
    favorite_reviews.where(user_id: user.id).exists?
  end
  
  # お気に入りのレビューの数を返すメソッド
  def favorite_reviews_count
    favorite_reviews.count
  end
  
  # 作成日時の降順でレビューを並べ替えるスコープ
  scope :latest, -> {order(created_at: :desc)}
  
  # 作成日時の昇順でレビューを並べ替えるスコープ
  scope :old, -> {order(created_at: :asc)}
  
  # 星の数でレビューを降順で並べ替えるスコープ
  scope :star_count, -> {order(star: :desc)} 
  
  # お気に入りレビューの数でレビューを降順で並べ替えるスコープ
  scope :favorite_reviews_count, -> { order(favorite_reviews_count: :desc) }
  
end
