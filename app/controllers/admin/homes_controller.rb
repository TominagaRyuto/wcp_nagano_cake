class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    case params[:order_sort]
    when "0"
      @customer = Customer.find_by(id: params[:id])
      @orders = @customer.orders.page(params[:page]).per(10).order("id DESC")
    else
      @orders = Order.page(params[:page]).per(10).order("id DESC")
    end
  end
end
