# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  email: "admin@admin",
  password:  "1234567890",
  name: "admin",
  introduction: "管理者です",
  admin: true
  )

5.times do |n|
  User.create!(
    email: "user#{n + 1}@example.com",
    password: "password",
    name: "User #{n + 1}",
    introduction: "これはユーザー #{n + 1} です。"
  )
end

  Genre.create([
  { id: "567170", name: "ゲーミングキーボード" },
  { id: "565171", name: "ゲーミングマウス" },
  { id: "552391", name: "ゲーミングマウスパッド" },
  { id: "567169", name: "ゲーミングヘッドセット" },
  { id: "567167", name: "ゲーミングイヤホン" },
  { id: "110105", name: "ゲーミングモニター" },
  { id: "211549", name: "ゲームパッド" },
  # 他のジャンルも追加可
  ])

  Tag.create([
  { name: "logicool" },
  { name: "Razer" },
  { name: "ELECOM" },
  { name: "ASUS" },
  { name: "CORSAIR" },
  { name: "ロジテック" },
  { name: "audio-technica" },
  { name: "MSI" },
  { name: "オムロン" },
  { name: "COOLERMASTERR" },
  { name: "プリンストン" },
  { name: "NZXT" },
  { name: "CENTURY" },
  { name: "SONY" },
  { name: "Acer" },
  { name: "BUFFALO" },
  { name: "Max" },
  { name: "サンワサプライ" },
  { name: "BenQ" },
  { name: "SENNHEISER" },
  # 他のジャンルも追加可
  ])