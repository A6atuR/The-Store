class AddressesController < ApplicationController
  authorize_resource
  
  def new
    @address = Address.new 
  end

  def create
    @order = current_customer.current_order
    @address = Address.new(address_params)
    if @address.save
      @order.update_attribute(:address_id, @address.id)
      redirect_to new_credit_card_path
    else
      render 'new'
    end 
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @order = current_customer.current_order
    @address = Address.find(params[:id])
    @address.update(address_params)
    if @address.save
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
