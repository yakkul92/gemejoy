class FavoriteReviewsController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    @favorite = current_user.favorite_reviews.new(review: review)
    @favorite.save
    render 'replace_btn'
  end

  def destroy
    review = Review.find(params[:review_id])
    @favorite = current_user.favorite_reviews.find_by(review: review)
    @favorite.destroy
    render 'replace_btn'
  end
end

