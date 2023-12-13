class CreateItemsTagsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :items, :tags, id: false do |t|
  end

    add_index :items_tags, [:item_id, :tag_id]
    add_index :items_tags, [:tag_id, :item_id]
  end
end
