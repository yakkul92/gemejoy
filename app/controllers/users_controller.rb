class UsersController < ApplicationController
   before_action :authenticate_user!
   
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    user.update(is_active: true)
    user.update(user_params)
    redirect_to user_path(@user)
  end  

  def unsubscribe
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :is_active)
  end
  
end
