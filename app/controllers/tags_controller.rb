class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]
  
  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
    @tags = Tag.all
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path, notice: 'タグが作成されました'
    else
      flash.now[:alert] = 'エラーがあります。'
      render 'index'
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path, notice: 'タグが更新されました'
    else
      flash.now[:alert] = 'エラーがあります。'
      render 'edit'
    end
  end
  
  def destroy
    if @tag.destroy
      redirect_to tags_path, notice: 'タグが削除されました'
    else
      flash.now[:alert] = 'エラーがあります。'
      render 'edit'
    end
  end    

private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end
