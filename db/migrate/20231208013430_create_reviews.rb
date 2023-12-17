class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer :user_id
      t.integer :item_id
      t.string :comment
      t.float :star
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
