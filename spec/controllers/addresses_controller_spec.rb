require 'spec_helper'

describe AddressesController do
  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #edit" do
    before (:each) do
      @customer = create(:customer)
      sign_in @customer
    end

    it "responds successfully with an HTTP 200 status code if this address belongs to current customer" do
      @address = create(:address, customer_id: @customer.id)
      get :edit, id: @address.id
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the edit template if this address belongs to current customer" do
      @address = create(:address, customer_id: @customer.id)
      get :edit, id: @address.id
      expect(response).to render_template("edit")
    end
  end

  describe "POST create" do 
    let(:customer) { stub_model(Customer, current_order: order) }
    let(:order) { create(:order) }

    before (:each) do
      allow(controller).to receive(:current_customer) { customer }
    end
      
    it "redirects to the new credit_card_path if address is valid" do
      post :create, address: attributes_for(:address) 
      response.should redirect_to new_credit_card_path 
    end

    it "re-renders the new template if address is invalid" do
      post :create, address: attributes_for(:invalid_address) 
      response.should render_template :new
    end
  end

  describe "PATCH update" do 
    before (:each) do
      @customer = create(:customer)
      @order = @customer.orders.in_progress.first
      allow(controller).to receive(:current_customer) { @customer }
      @address = create(:address, customer_id: @customer.id)
    end

    it "re-renders the edit template if address is invalid" do
      patch :update, id: @address.id, address: attributes_for(:invalid_address) 
      response.should render_template :edit
    end

    it "redirects to the order_confirm_path if address is valid and belongs to current customer" do
      patch :update, id: @address.id, address: attributes_for(:address, address: "Street", customer_id: @customer.id) 
      response.should redirect_to order_confirm_path(@order) 
    end
  end
end