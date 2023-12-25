class ApplicationController < ActionController::Base
  
  # Deviseコントローラーの場合、configure_permitted_parameters メソッドを実行する前に呼び出す
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # アクションの実行前にユーザーの認証を確認する
  before_action :authenticate_user!

protected 

# Deviseの設定: サインアップ時に許可されるパラメータを構成
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end 
  
end
