class AddressesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  
  def new
    @address = Address.new 
  end

  def create
    @order = current_customer.current_order
    @address = current_customer.addresses.new(address_params)
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
