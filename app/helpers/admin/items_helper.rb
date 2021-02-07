module Admin::ItemsHelper
  def tax
    @tax = (@item.price*1.1).to_i
  end
end
