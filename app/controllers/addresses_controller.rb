class AddressesController < ApplicationController
  load_and_authorize_resource
  
  def new
  end

  def create
    @order = current_customer.current_order
    @address.customer = current_customer
    if @address.save
      @order.update_attribute(:address_id, @address.id)
      redirect_to new_credit_card_path
    else
      render 'new'
    end 
  end

  def edit
  end

  def update
    @order = current_customer.current_order
    if @address.update(address_params)
      redirect_to order_confirm_path(@order)
    else
      render 'edit'
    end 
  end

  private

  def address_params
    params.require(:address).permit(:address, :city, :zip_code, :phone)
  end
end