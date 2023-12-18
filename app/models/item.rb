class Item < ApplicationRecord
  
  has_many :reviews
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :tags
  has_many :favorite_items, dependent: :destroy
    
  def favorited_item_by?(user)
    favorite_items.where(user_id: user.id).exists?
  end
  
  def favorite_items_count
    favorite_reviews.count
  end
  
  scope :price_desc, -> {order(price: :desc)} 
  scope :price_asc, -> {order(price: :asc)} 
  scope :favorite_items_count, -> { order(favorite_items_count: :desc) }
  
end
