class OrdersController < ApplicationController
  before_action :authenticate_user!, :set_item, :my_product?, :item_sold_out?, only: [:index]

  def index
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)
    if @form.valid?
      pay_item
      @form.save
      redirect_to controller: :items, action: :index
    else
      set_item
      render :index
    end
  end

  private

  def form_params
    params.require(:form).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token], price: params[:price])
  end
  
  def set_item 
    @item = Item.find(params[:item_id])
  end

  def my_product?
    if @item.user.id == current_user.id
      redirect_to controller: :items, action: :index
    end
  end

  def pay_item
    Payjp::api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: form_params[:price],
      card: form_params[:token],
      currency: 'jpy'
    )
  end

  def item_sold_out?
    unless Purchase.find_by(item_id: @item.id).blank?
      redirect_to controller: :items, action: :index
    end
  end

end
