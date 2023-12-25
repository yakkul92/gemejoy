class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.string :name
      t.string :shop_code
      t.integer :price
      t.string :genre_id
      t.string :rakuten_url
      t.text :image_url
      t.text :caption
      t.timestamps
      
    end
  end
end
