class OrdersController < ApplicationController
  before_action :select_item, only: [:index, :create]
  before_action :authenticate_user!, only: [:index]

  def index
    return redirect_to root_path if current_user.id == select_item.user_id || select_item.order!=nil 
    
    @item_order = PayForm.new 
  end
 
  def create
    @item_order = PayForm.new(item_order_params)

    if @item_order.valid?
      @item_order.save
      pay_item
      return redirect_to root_path
    else
    render 'index'
    end
  end

  private

  def select_item
    @item = Item.find(params[:item_id])
  end

  def item_order_params
    params.permit(
      :item_id,
      :token,
      :postal_code,
      :prefecture_id,
      :city,
      :addresses,
      :building,
      :phone_number
    ).merge(user_id: current_user.id)
  end


  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] #環境変数と合わせましょう
    Payjp::Charge.create(
      amount: @item.price, # 決済額
      card: item_order_params[:token], # カード情報const tokenObj = `<input value=${token} type="hidden" name='token'>`;
      currency: 'jpy' # 通貨単位
    )
  end
end