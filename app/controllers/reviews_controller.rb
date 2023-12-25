class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @review.user = current_user

    if @review.save
      # 成功時の処理...
      redirect_to review_path(@review), notice: 'レビューが投稿されました'
    else
      # エラー時の処理...
      flash.now[:alert] = '入力エラーがあります。'
      @item = Item.find(params[:review][:item_id])
      render 'items/show'
    end
  end


  def index
    @reviews = Review.where(is_active: true, users: { is_active: true }).includes(:user)
    # @reviews = Review.where(is_active: true)
    # @reviews = Review.all

    if params[:latest]
      @reviews = @reviews.latest
    elsif params[:old]
      @reviews = @reviews.old
    elsif params[:star_count]
      @reviews = @reviews.star_count
    elsif params[:favorite_reviews_count]
      @reviews = @reviews.favorite_reviews_count  
    else
      @reviews
    end
    
    if params[:search_word].present?
      @reviews = @reviews.joins(:item).where("items.name LIKE ?", "%#{params[:search_word]}%")
    end
    render 'reviews/index'    
    
  end

  def show
    @review = Review.find(params[:id])
    @review_comments = @review.review_comments.joins(:user).where(users: { is_active: true })
    @review_comment = ReviewComment.new
  end

  def edit
    @review = Review.find(params[:id])
    @review_comments = @review.review_comments.joins(:user).where(users: { is_active: true })
    @review_comment = ReviewComment.new
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      # 成功時の処理...
      redirect_to review_path(@review), notice: 'レビューが更新されました'
    else
      # エラー時の処理...
      flash.now[:alert] = '入力エラーがあります。'
      render 'reviews/show'
    end    
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      # 成功時の処理...
      redirect_to reviews_path, notice: 'レビューが削除されました'
    else
      # エラー時の処理...
      flash.now[:alert] = 'エラーがあります。'
      render 'reviews'
    end    
  end

private
  def review_params
    params.require(:review).permit(:item_id, :user_id, :comment, :star, :is_active)
  end

end
