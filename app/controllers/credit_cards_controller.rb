class CreditCardsController < ApplicationController
  load_and_authorize_resource
  
  def new
  end

  def create
    @order = current_customer.current_order
    @credit_card.customer = current_customer
    if @credit_card.save
      @order.update_attribute(:credit_card_id, @credit_card.id)
      redirect_to order_confirm_path(@order)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @order = current_customer.current_order
    if @credit_card.update(credit_card_params)
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