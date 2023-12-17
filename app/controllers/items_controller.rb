class ItemsController < ApplicationController
  
  before_action :set_default_genre_id, only: [:search]
  
  # 商品詳細表示ページ
  def show
    @item = Item.find(params[:id])
    @review = Review.new
    @reviews = @item.reviews
  end

  # 商品検索アクション
  def search
    @items = []
    @keyword = params[:keyword]
    @genre_ids = params[:genre_ids] || []
    puts "@genre_ids: #{ @genre_ids.inspect }"
    @tag_ids = params[:tag_ids] || []

    if @keyword.present? || @genre_ids.present? || @tag_ids.present?
      # APIで取得したデータを格納する
      results = RakutenWebService::Ichiba::Item.search(search_params)

      # itemsに取得データを格納する
      results.each do |result|
        item = Item.find_or_initialize_by(name: result["itemName"]) # 名前で検索
        item.attributes = read(result)
        item.save
        @items << item
      end
    end
    # 検索条件をビューに渡す
    @search_conditions = {
      keyword: @keyword,
      genre_ids: @genre_ids,
      tag_ids: @tag_ids
    }  
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
  
  # genreId のデフォルト値を設定
  def set_default_genre_id
    @genre_ids ||= ["567167"] if @genre_ids.blank?
  end


  # API検索用のパラメータを組み立てる
  def search_params
    search_conditions = {}
  
    # keyword の条件
    if @keyword.present?
      search_conditions[:keyword] = "#{@keyword} #{tag_keywords}"
    elsif @tag_ids.present?
      # keyword がなくても tag だけが選択されている場合、tag_keywords を利用する
      search_conditions[:keyword] = tag_keywords
    end

    # genreId の条件
    if @genre_ids.present? && @genre_ids.first != "0"
      # genreId を複数の数値に変換し、配列のまま格納
      puts @genre_ids.inspect  # この行を追加
      search_conditions[:genreId] = @genre_ids.map(&:to_i)
    elsif @keyword.present?
      # キーワードのみで検索した場合、genreId を固定する
      @genre_ids = ["567167"]
      search_conditions[:genreId] = @genre_ids.map(&:to_i)
    end

    search_conditions
  end

  # タグのキーワードを取得
  def tag_keywords
    Tag.where(id: @tag_ids).pluck(:name).join(" ")
  end
end
