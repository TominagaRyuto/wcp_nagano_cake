class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).reverse_order
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_items_path
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end

  def edit
    @item = Item.find(params[:id])
    @genre = Genre.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :image, :name, :introduction, :price)
  end

end
