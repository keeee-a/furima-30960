class OrdersController < ApplicationController
  def index
    set_item
  end

  private

  def set_item 
    @item = Item.find(params[:item_id])
  end

end
