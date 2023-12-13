class CreateGenresItemsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :genres_items, id: false do |t|
      t.belongs_to :genre
      t.belongs_to :item
    end
  end
end
