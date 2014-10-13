require 'controllers/controllers_spec_helper'

describe OrdersController do
  before do
    @customer = Customer.create(email: 'test@gmail.com', password: '12345678')
    @order = create(:order)
    allow(controller).to receive(:current_customer) { @customer }
    redefine_cancan_abilities
  end

  context "GET #index" do
    context 'being signed in' do
      before do
        sign_in @customer
        get :index
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end

    context 'being not signed in' do
      before do
        get :index
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :index' do
      before do
        sign_in @customer
        @ability.cannot :index, Order
        get :index
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #shopping_cart" do
    context 'being signed in' do
      before do
        sign_in @customer
        get :shopping_cart
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the shopping_cart template" do
        expect(response).to render_template("shopping_cart")
      end
    end

    context 'being not signed in' do
      before do
        get :shopping_cart
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the shopping_cart template" do
        expect(response).to render_template("shopping_cart")
      end
    end

    context 'cancan doesnt allow :shopping_cart' do
      before do
        sign_in @customer
        @ability.cannot :shopping_cart, Order
        get :shopping_cart
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #show" do
    context 'being signed in' do
      before do
        sign_in @customer
        get :show, id: @order.id
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the show template" do
        expect(response).to render_template("show")
      end
    end

    context 'being not signed in' do
      before do
        get :show, id: @order.id
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :show' do
      before do
        sign_in @customer
        @ability.cannot :show, Order
        get :show, id: @order.id
      end

      it { should redirect_to root_path }
    end
  end

  context "GET #confirm" do
    context 'being signed in' do
      before do
        sign_in @customer
        get :confirm, order_id: @order.id
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the confirm template" do
        expect(response).to render_template("confirm")
      end
    end

    context 'being not signed in' do
      before do
        get :confirm, order_id: @order.id
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :confirm' do
      before do
        sign_in @customer
        @ability.cannot :confirm, Order
        get :confirm, order_id: @order.id
      end

      it { should redirect_to root_path }
    end
  end

  context "PATCH update" do 
    context 'being signed in' do
      before do
        sign_in @customer
        patch :update, id: @order.id, order: attributes_for(:order) 
      end

      it "redirects to the orders_path if order is valid" do
        response.should redirect_to order_complete_path(Order.last)
      end
    end

    context 'being not signed in' do
      before do
        patch :update, id: @order.id, order: attributes_for(:order) 
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :update' do
      before do
        sign_in @customer
        @ability.cannot :update, Order
        patch :update, id: @order.id, order: attributes_for(:order) 
      end

      it { should redirect_to root_path }
    end
  end
end