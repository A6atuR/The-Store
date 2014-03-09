class CreditCardsController < ApplicationController
  authorize_resource
  
  def new
    @credit_card = CreditCard.new
  end

  def create
    @order = current_customer.current_order
    @credit_card = current_customer.credit_cards.new(credit_card_params)
    if @credit_card.save
      @order.update_attribute(:credit_card_id, @credit_card.id)
      redirect_to order_confirm_path(@order)
    else
      render 'new'
    end
  end

  def edit
    @credit_card = CreditCard.find(params[:id])
  end

  def update
    @order = current_customer.current_order
    @credit_card = CreditCard.find(params[:id])
    @credit_card.update(credit_card_params)
    if @credit_card.save
      redirect_to order_confirm_path(@order)
    else
      render 'edit'
    end 
  end
 
  private

  def credit_card_params
    params.require(:credit_card).permit(:number, :cvv, :expiration_month, :expiration_year)
  end
end
