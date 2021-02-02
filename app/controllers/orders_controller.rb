class OrdersController < ApplicationController
  def index
    set_item
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)
    if @form.valid?
      @form.save
      redirect_to controller: :items, action: :index
    else
      set_item
      render :index
    end
  end

  private

  def form_params
    params.require(:form).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item 
    @item = Item.find(params[:item_id])
  end

end
