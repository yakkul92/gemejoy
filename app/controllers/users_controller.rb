class UsersController < ApplicationController
   before_action :authenticate_user!
   
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @favorite_items = @user.favorite_items.includes(:item)
    @favorite_reviews = @user.favorite_reviews.includes(:review)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(is_active: true)
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'ユーザー情報が更新されました。'
    else
      render :edit
    end
  end  

  def unsubscribe
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_active: false)
    reset_session
    redirect_to root_path, notice: "退会処理を実行いたしました"
  end
  
  def user_status
    @user = User.find(params[:id])
    @user.update(is_active: !@user.is_active)
    redirect_to users_path, notice: "ユーザーのステータスを更新しました。"
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :is_active)
  end
  
end
