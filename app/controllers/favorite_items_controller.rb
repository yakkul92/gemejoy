class FavoriteItemsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    # 現在のユーザーに紐づくお気に入りアイテムを新しく作成
    @favorite = current_user.favorite_items.new(item: item)
    @favorite.save
    render 'replace_btn'
  end

  def destroy
    item = Item.find(params[:item_id])
    # 現在のユーザーに紐づくお気に入りアイテムを検索
    @favorite = current_user.favorite_items.find_by(item: item)
    # @favorite = current_user.favorite_items.where(item: item).first whereは空のコレクションを返すので最初の要素を取得必要
    @favorite.destroy
    render 'replace_btn'
  end
  
end
