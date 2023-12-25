class ReviewComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :review
  
  validates :content, presence: { message: "空白は許可されません" }
  
end
