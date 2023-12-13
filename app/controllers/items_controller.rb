class ItemsController < ApplicationController
  # 商品一覧表示ページ
  def index
  end

  # 商品詳細表示ページ
  def show
    @item = Item.find(params[:id])
    @review = Review.new
    @reviews = @item.reviews
  end

  # 商品編集ページ
  def edit
  end
  
  # 商品検索アクション
  def search
    @items = []
    @keyword = params[:keyword]
    @genre_ids = params[:genre_ids] || []
  
    if @keyword.present? || @genre_ids.present?
      # APIで取得したデータを格納する
      results = RakutenWebService::Ichiba::Item.search({
        keyword: params[:keyword],
        genreId: @genre_ids.join(",")
      })
  
      # itemsに取得データを格納する
      results.each do |result|
        item = Item.find_or_initialize_by(name: result["itemName"]) # 名前で検索 
        #find_or_initialize_by 既存テーブルにデータがあればfind_byの結果を返してくれて、なければnewしてインスタンスを作ってくれます。
        item.attributes = read(result)
        # 保存
        item.save
        @items << item
      end
    end
  end  

  private
  # APIから取得したデータをパースしてモデル用のデータに変換する
  def read(result)
    name = result["itemName"]
    shop_code = result["shopCode"]
    price = result["itemPrice"]
    genre_id = result["genreId"]
    rakuten_url = result["itemUrl"]
    image_url = result["mediumImageUrls"]
    caption = result["itemCaption"]
    {
      name: name,
      shop_code: shop_code,
      price: price,
      genre_id: genre_id,
      rakuten_url: rakuten_url,
      image_url: image_url,
      caption: caption,
    }
  end
end
