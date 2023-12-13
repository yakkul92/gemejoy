class Item < ApplicationRecord
  
  has_many :reviews
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :tags
  
end
