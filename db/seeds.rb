# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者の作成
User.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  name: ENV['ADMIN_NAME'],
  introduction: ENV['ADMIN_INTRODUCTION'],
  admin: true
)

# テストユーザーの作成
3.times do |n|
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

# テストアイテムの作成
3.times do |n|
  item = Item.create!(
    name: "商品#{n + 1}",
    shop_code: "SHOP00#{n + 1}",
    price: (n + 1) * 1000,
    genre_id: "T00#{n + 1}",
    rakuten_url: "https://example.com/item#{n + 1}",
    image_url: '["no_image.jpg", "image2.jpg", "image3.jpg"]',
    caption: "これは商品 #{n + 1} です。"
  )

  # 既存のレビューがない場合のみ新しいレビューを作成
  unless Review.exists?(item_id: item.id)
    # レビューの作成
    review = Review.create!(
      user_id: User.all.sample.id,
      item_id: item.id,
      comment: "これは商品 #{item.id} へのレビューです。",
      star: rand(1..5),
      is_active: true
    )

    # レビューコメントの作成
    2.times do
      ReviewComment.create!(
        content: "これはレビューへのコメントです。",
        user_id: User.all.sample.id,
        review_id: review.id
      )

      # いいね（レビューに対する）
      FavoriteReview.create!(
        user_id: User.all.sample.id,
        review_id: review.id
      )

      # いいね（商品に対する）
      FavoriteItem.create!(
        user_id: User.all.sample.id,
        item_id: item.id
      )
    end
  end
end


