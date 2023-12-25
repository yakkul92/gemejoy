class ReviewCommentsController < ApplicationController
  before_action :set_review, only: [:create, :destroy]
  
  def create
    # @review = Review.find(params[:review_id])
    @review_comment = ReviewComment.new(review_comment_params)
    # コメントにユーザー情報と対象レビューのIDを紐付け
    @review_comment.user_id = current_user.id
    @review_comment.review_id = @review.id

    if @review_comment.save
      redirect_to review_path(@review), notice: 'コメントが投稿されました'
    else
      flash.now[:alert] = '入力エラーがあります。'
      @review_comments = @review.review_comments
      render 'reviews/show'
    end
  end
  
  def destroy
    # @review = Review.find(params[:review_id])
    @review_comments = @review.review_comments
    @review_comment = ReviewComment.find_by(id: params[:id], review_id: params[:review_id])

    if @review_comment.destroy
      redirect_to review_path(@review), notice: 'コメントが削除'
    else
      render 'reviews/show'
    end
  end
  
private
  def set_review
    @review = Review.find(params[:review_id])
  end

  def review_comment_params
    params.require(:review_comment).permit(:content)
  end
  
end
