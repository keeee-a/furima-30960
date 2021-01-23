class ItemsController < ApplicationController
  def index
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :category_id, :price, :explanation, :product_condition_id, :burden_shipping_id, :shipping_area_id, :days_to_ship_id, :image).merge(user_id: current_user.id)
  end
end
