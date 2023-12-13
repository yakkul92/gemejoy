class Item < ApplicationRecord
  
  has_many :reviews
  has_and_belongs_to_many :genres
  
end
