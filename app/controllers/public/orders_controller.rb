class Public::OrdersController < ApplicationController
  def index
    @orders = current_customer.orders.page(params[:page]).per(8).order("id DESC")
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @workflow = params[:order][:workflow]
    if @workflow == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name =current_customer.last_name+current_customer.first_name
    elsif @workflow == "2"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif @workflow == "3"
      @address = Address.new
      @address.customer_id = current_customer.id
      @address.name = @order.name
      @address.postal_code = @order.postal_code
      @address.address = @order.address
      @address.save
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item_id
        @order_detail.price = cart_item.item.price
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end
      @cart_items.destroy_all
      render :thanks
    else
      @addresses = current_customer.addresses
      render :new
    end
  end


  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :customer_id, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

  def workflow_param
    params.permit(:workflow)
  end

  def address_id_param
    params.permit(:address_id)
  end

end
