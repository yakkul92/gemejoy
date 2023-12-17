class Item < ApplicationRecord
  
  has_many :reviews
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :tags
  has_many :favorite_items, dependent: :destroy
    
  def favorited_item_by?(user)
    favorite_items.where(user_id: user.id).exists?
  end
  
end
