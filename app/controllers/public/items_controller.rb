class Public::ItemsController < ApplicationController
  before_action :authenticate,except: [:index, :show]
  def index
    @items = Item.page(params[:page]).per(8).order("id DESC")
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
  end
end
