class RegistrationsController < ApplicationController
  before_action :authenticate_customer!
  
  def edit
    @billing_address = Address.new(first_name: cookies[:billing_first_name], last_name: cookies[:billing_last_name], address: cookies[:billing_address], zip_code: cookies[:billing_zip_code], city: cookies[:billing_city], country_id: cookies[:billing_country_id], phone: cookies[:billing_phone])
    @shipping_address = Address.new(first_name: cookies[:shipping_first_name], last_name: cookies[:shipping_last_name], address: cookies[:shipping_address], zip_code: cookies[:shipping_zip_code], city: cookies[:shipping_city], country_id: cookies[:shipping_country_id], phone: cookies[:shipping_phone])
    @customer = current_customer
  end

  def create_billing_address
    @shipping_address = Address.new
    @customer = current_customer
    @billing_address = current_customer.addresses.create(address_params)
    if @billing_address.save
      cookies.permanent[:billing_first_name] = @billing_address.first_name
      cookies.permanent[:billing_last_name] = @billing_address.last_name
      cookies.permanent[:billing_address] = @billing_address.address
      cookies.permanent[:billing_zip_code] = @billing_address.zip_code
      cookies.permanent[:billing_city] = @billing_address.city
      cookies.permanent[:billing_country_id] = @billing_address.country_id
      cookies.permanent[:billing_phone] = @billing_address.phone
      @billing_address.destroy
      flash[:success] = "Billing address has been successfully created"
      redirect_to edit_account_customers_path
    else
      render "edit"
    end
  end

  def create_shipping_address
    @billing_address = Address.new
    @customer = current_customer
    @shipping_address = current_customer.addresses.create(address_params)
    if @shipping_address.save
      cookies.permanent[:shipping_first_name] = @shipping_address.first_name
      cookies.permanent[:shipping_last_name] = @shipping_address.last_name
      cookies.permanent[:shipping_address] = @shipping_address.address
      cookies.permanent[:shipping_zip_code] = @shipping_address.zip_code
      cookies.permanent[:shipping_city] = @shipping_address.city
      cookies.permanent[:shipping_country_id] = @shipping_address.country_id
      cookies.permanent[:shipping_phone] = @shipping_address.phone
      @shipping_address.destroy
      flash[:success] = "Shipping address has been successfully created"
      redirect_to edit_account_customers_path
    else
      render "edit"
    end
  end

  def update_email
    @shipping_address = Address.new
    @billing_address = Address.new
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      sign_in @customer, :bypass => true
      flash[:success] = "Email has been successfully updated"
      redirect_to edit_account_customers_path
    else
      render "edit"
    end
  end

  def update_password
    @shipping_address = Address.new
    @billing_address = Address.new
    @customer = Customer.find(current_customer.id)
    if @customer.update_with_password(customer_params)
      sign_in @customer, :bypass => true
      flash[:success] = "Password has been successfully updated"
      redirect_to edit_account_customers_path
    else
      render "edit"
    end
  end

  def destroy_account
    @shipping_address = Address.new
    @billing_address = Address.new
    @customer = Customer.find(current_customer.id)
    @customer.update(customer_params)
    if @customer.confirmation_delete == true
      @customer.destroy
      flash[:success] = "Your account has been successfully removed"
      redirect_to root_url
    else
      flash.now[:error] = "You must accept terms of service"
      render "edit"
    end
  end

  private

  def customer_params
    params.required(:customer).permit(:email, :password, :current_password, :confirmation_delete)
  end

  def address_params
    params.require(:address).permit(:address, :city, :zip_code, :phone, :first_name, :last_name, :country_id, :shipping, :address_type)
  end
end