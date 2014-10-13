class CreditCardsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_customer!
  
  def new
    @credit_card = CreditCard.new(number: cookies[:number], cvv: cookies[:cvv], expiration_date: cookies[:expiration_date])
  end

  def create
    @credit_card.customer = current_customer
    if @credit_card.save
      @order.update_attribute(:credit_card_id, @credit_card.id)
      cookies.permanent[:number] = @credit_card.number
      cookies.permanent[:expiration_date] = @credit_card.expiration_date
      cookies.permanent[:cvv] = @credit_card.cvv
      flash[:success] = "Credit Card has been successfully created"
      redirect_to order_confirm_path(@order)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @credit_card.update(credit_card_params)
      flash[:success] = "Credit Card has been successfully updated"
      redirect_to order_confirm_path(@order)
    else
      render 'edit'
    end 
  end
 
  private

  def credit_card_params
    params.require(:credit_card).permit(:number, :cvv, :expiration_date)
  end
end