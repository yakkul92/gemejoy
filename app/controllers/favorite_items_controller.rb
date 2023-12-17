class FavoriteItemsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    @favorite = current_user.favorite_items.new(item: item)
    @favorite.save
    render 'replace_btn'
  end

  def destroy
    item = Item.find(params[:item_id])
    @favorite = current_user.favorite_items.find_by(item: item)
    @favorite.destroy
    render 'replace_btn'
  end  
end
