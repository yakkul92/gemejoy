class Item < ApplicationRecord
  
  has_many :reviews
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :tags
  has_many :favorite_items, dependent: :destroy
  
  # 特定のユーザーがアイテムをお気に入りにしているかどうかを確認するメソッド  
  def favorited_item_by?(user)
    favorite_items.where(user_id: user.id).exists?
  end
  
  # お気に入りのレビューの数を返すメソッド
  def favorite_items_count
    favorite_reviews.count
  end
  
  # 価格の降順でアイテムを並べ替えるスコープ
  scope :price_desc, -> {order(price: :desc)}
  
  # 価格の昇順でアイテムを並べ替えるスコープ
  scope :price_asc, -> {order(price: :asc)} 
  
  # いいねの数でアイテムを並べ替えるスコープ
  scope :favorite_items_count, -> { order(favorite_items_count: :desc) }
  
end
