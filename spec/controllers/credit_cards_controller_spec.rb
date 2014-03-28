require 'controllers/controllers_spec_helper'

describe CreditCardsController do
  before do
    @customer = create(:customer)
    @order = @customer.orders.in_progress.first
    allow(controller).to receive(:current_customer) { @customer }
    @credit_card = create(:credit_card)
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
        @ability.cannot :new, CreditCard
        get :new
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #edit" do
    context 'being signed in' do
      before (:each) do
        sign_in @customer
        get :edit, id: @credit_card.id
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
        get :edit, id: @credit_card.id
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :edit' do
      before do
        sign_in @customer
        @ability.cannot :edit, CreditCard
        get :edit, id: @credit_card.id
      end

      it { should redirect_to root_path }
    end
  end

  context "POST create" do
    context 'being signed in' do
      before (:each) do
        sign_in @customer
      end

      it "redirects to order_confirm_path if address is valid" do
        post :create, credit_card: attributes_for(:credit_card) 
        expect(response).to be_success
      end

      it "re-renders the new template if credit_card is invalid" do
        post :create, credit_card: attributes_for(:invalid_credit_card) 
        response.should render_template :new
      end
    end

    context 'being not signed in' do
      before do
        post :create, credit_card: attributes_for(:credit_card) 
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :create' do
      before do
        sign_in @customer
        @ability.cannot :create, CreditCard
        post :create, credit_card: attributes_for(:credit_card) 
      end

      it { should redirect_to root_path }
    end
  end

  context "PATCH update" do 
    context 'being signed in' do
      before (:each) do
        sign_in @customer
      end
      
      it "redirects to the order_confirm_path if credit_card is valid" do
        patch :update, id: @credit_card.id, credit_card: attributes_for(:credit_card, cvv: 2222) 
        response.should redirect_to order_confirm_path(@order) 
      end

      it "re-renders the edit template if credit_card is invalid" do
        patch :update, id: @credit_card.id, credit_card: attributes_for(:invalid_credit_card) 
        response.should render_template :edit
      end
    end

    context 'being not signed in' do
      before do
        patch :update, id: @credit_card.id, credit_card: attributes_for(:credit_card, cvv: 2222)
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :update' do
      before do
        sign_in @customer
        @ability.cannot :update, CreditCard
        patch :update, id: @credit_card.id, credit_card: attributes_for(:credit_card, cvv: 2222)
      end

      it { should redirect_to root_path }
    end
  end
end