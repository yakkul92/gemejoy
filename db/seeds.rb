# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  email: "admin@example.jp",
  password:  "abcd1234",
  name: "管理者",
  introduction: "管理者です",
  admin: true
  )
  
  Genre.create([
  { id: "567170", name: "ゲーミングキーボード" },
  # 他のジャンルも追加
  ])
  
  Tag.create([
  { name: "ゲーミングマウス" },
  { name: "logicool" },
  # 他のジャンルも追加
  ])
  
  
# genres_data = Item.select(:genre_id).distinct.pluck(:genre_id)

# genres_data.each do |genre_id|
#   Genre.create(name: "ジャンル#{genre_id}", genre_id: genre_id)
# end

# # 上記で作成したジャンルを元に、items_genres テーブルを更新
# Item.find_each do |item|
#   genre = Genre.find_by(genre_id: item.genre_id)
#   item.genres << genre if genre.present?
# end