class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @review.user = current_user

    if @review.save
      # 成功時の処理...
      redirect_to reviews_path
    else
      # エラー時の処理...
      Rails.logger.error("Review creation failed: #{@review.errors.full_messages}")
      flash[:error] = "レビューの投稿に失敗しました。"
      render :new
    end
  end


  def index
    @reviews = Review.where(is_active: true, users: { is_active: true }).includes(:user)
    # @reviews = Review.where(is_active: true)
    # @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to review_path(review.id)
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to reviews_path
  end

private
  def review_params
    params.require(:review).permit(:item_id, :user_id, :comment, :star, :is_active)
  end

end
