class AddressesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_customer!
  
  def new
    @address = Address.new(first_name: cookies[:billing_first_name], last_name: cookies[:billing_last_name], address: cookies[:billing_address], zip_code: cookies[:billing_zip_code], city: cookies[:billing_city], country_id: cookies[:billing_country_id], phone: cookies[:billing_phone])
  end

  def new_shipping
    @shipping_address = Address.new(first_name: cookies[:shipping_first_name], last_name: cookies[:shipping_last_name], address: cookies[:shipping_address], zip_code: cookies[:shipping_zip_code], city: cookies[:shipping_city], country_id: cookies[:shipping_country_id], phone: cookies[:shipping_phone])
  end

  def create
    @address = @order.addresses.create(address_params)
    @address.customer = current_customer
    if @address.save
      if @address.shipping == true
        @shipping_address = @order.addresses.create(address_params)
        @shipping_address.update_attributes(address_type: "shipping", customer_id: current_customer.id)
        flash[:success] = "Both addresses have been successfully created"
        redirect_to order_new_delivery_path(@order)
      else
        flash[:success] = "Billing address has been successfully created"
        redirect_to new_shipping_addresses_path
      end
    else
      render 'new'
    end 
  end

  def create_shipping
    @shipping_address = @order.addresses.create(address_params)
    if @shipping_address.save
      @shipping_address.update_attributes(address_type: "shipping", customer_id: current_customer.id)
      flash[:success] = "Shipping address has been successfully created"
      redirect_to order_new_delivery_path(@order)
    else
      render 'new_shipping'
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      flash[:success] = "Address has been successfully updated"
      redirect_to order_confirm_path(@order)
    else
      render 'edit'
    end 
  end

  private

  def address_params
    params.require(:address).permit(:address, :city, :zip_code, :phone, :first_name, :last_name, :country_id, :shipping)
  end
end