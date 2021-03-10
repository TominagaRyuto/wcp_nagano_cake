class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @items = Item.page(params[:page]).all.order("id ASC")
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      @genres = Genre.all
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      @genre = Genre.all
      render :edit
    end
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
