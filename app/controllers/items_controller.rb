class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end
  
  def search
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end
  
end
