class ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end
  
  def new
    authenticate_user!
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render "new"
    end
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :category_id, :price, :explanation, :product_condition_id, :burden_shipping_id, :shipping_area_id, :days_to_ship_id, :image).merge(user_id: current_user.id)
  end
end
