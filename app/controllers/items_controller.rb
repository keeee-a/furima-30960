class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]
  before_action :check_login, only: [:new, :edit]
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
    unless current_user.id == @item.user.id
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :category_id, :price, :explanation, :product_condition_id, :burden_shipping_id, :shipping_area_id, :days_to_ship_id, :image).merge(user_id: current_user.id)
  end

  def set_item 
    @item = Item.find(params[:id])
  end

  def check_login
    authenticate_user!
  end
end
