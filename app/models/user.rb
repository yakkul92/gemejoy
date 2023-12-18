class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    user = find_or_initialize_by(email: GUEST_USER_EMAIL)
    if user.new_record?  # まだ保存されていない新しいレコードの場合
      user.password = SecureRandom.urlsafe_base64
      user.name ||= "guestuser"  # ユーザー名が未設定の場合のみデフォルト値を設定
      user.save!
    end
    user
  end

  has_many :reviews
  has_many :favorite_reviews, dependent: :destroy
  has_many :favorite_items, dependent: :destroy

  # 無効なユーザーアカウントはログインできないようにする
  def active_for_authentication?
    super && is_active?
  end
  
  # 無効なユーザーアカウントにエラーメッセージを表示しない
  def inactive_message
    is_active? ? super : :account_inactive
  end

end
