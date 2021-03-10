class Public::HomesController < ApplicationController
  def top
    @items=Item.page(params[:page]).per(4).order("id DESC")
  end

  def about
  end
end

