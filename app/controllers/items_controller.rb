class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :redirect_to_index, only: [:edit, :destroy]
  
  def index
    @items = Item.all.order(created_at: "DESC")
  end
  
  def new
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
  
  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    if  @item.destroy
      redirect_to action: :index
    else 
      render :show
    end
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :category_id, :price, :explanation, :product_condition_id, :burden_shipping_id, :shipping_area_id, :days_to_ship_id, :image).merge(user_id: current_user.id)
  end

  def set_item 
    @item = Item.find(params[:id])
  end

  def redirect_to_index
    unless current_user.id == @item.user.id
      redirect_to action: :index
    end
  end

end
