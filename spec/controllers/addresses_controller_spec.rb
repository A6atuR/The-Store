require 'controllers/controllers_spec_helper'

describe AddressesController do
  before do
    @customer = create(:customer)
    @order = @customer.orders.in_progress.first
    allow(controller).to receive(:current_customer) { @customer }
    @address = create(:address)
    redefine_cancan_abilities
  end

  context "GET #new" do
    context 'being signed in' do
      before do
        sign_in @customer
        get :new
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the new template" do
        expect(response).to render_template("new")
      end
    end

    context 'being not signed in' do
      before do
        get :new
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :new' do
      before do
        sign_in @customer
        @ability.cannot :new, Address
        get :new
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #edit" do
    context 'being signed in' do
      before (:each) do
        sign_in @customer
        get :edit, id: @address.id
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end
    end

    context 'being not signed in' do
      before do
        get :edit, id: @address.id
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :edit' do
      before do
        sign_in @customer
        @ability.cannot :edit, Address
        get :edit, id: @address.id
      end

      it { should redirect_to root_path }
    end
  end

  context "POST create" do
    context 'being signed in' do
      before (:each) do
        sign_in @customer
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

    context 'being not signed in' do
      before do
        post :create, address: attributes_for(:address) 
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :create' do
      before do
        sign_in @customer
        @ability.cannot :create, Address
        post :create, address: attributes_for(:address) 
      end

      it { should redirect_to root_path }
    end
  end

  context "PATCH update" do 
    context 'being signed in' do
      before (:each) do
        sign_in @customer
      end

      it "re-renders the edit template if address is invalid" do
        patch :update, id: @address.id, address: attributes_for(:invalid_address) 
        response.should render_template :edit
      end

      it "redirects to the order_confirm_path if address is valid" do
        patch :update, id: @address.id, address: attributes_for(:address, address: "Street") 
        response.should redirect_to order_confirm_path(@order) 
      end
    end

    context 'being not signed in' do
      before do
        patch :update, id: @address.id, address: attributes_for(:address, address: "Street")
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :update' do
      before do
        sign_in @customer
        @ability.cannot :update, Address
        patch :update, id: @address.id, address: attributes_for(:address, address: "Street")
      end

      it { should redirect_to root_path }
    end
  end
end