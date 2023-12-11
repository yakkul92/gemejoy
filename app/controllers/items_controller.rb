class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end
  
  def search
    @items = []
    @keyword = params[:keyword]
    
    if @keyword.present?
      #APIで取得したデータを格納する
      results = RakutenWebService::Ichiba::Item.search({
        keyword: params[:keyword],
        })
      
      #itemsに取得データを格納する
      results.each do |result|
        item = Item.new(read(result))
        @items << item
      end  
    end
    
    @items.each do |item|
      unless Item.exists?(name: item.name)
      item.save
      end
    end
  end

private
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