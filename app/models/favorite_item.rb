class FavoriteItem < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates_uniqueness_of :item_id, scope: :user_id
  
  # 最新のいいねを取得するスコープ
  scope :latest, -> { order(created_at: :desc) }

  # 最新のいいねに紐づく商品情報を取得するメソッド
  def self.recently_favorited_items(limit = 3)
    latest.limit(limit).includes(:item).map(&:item)
  end
end
