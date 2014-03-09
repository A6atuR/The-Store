require 'spec_helper'

describe OrdersController do
  let(:customer) { stub_model(Customer, current_order: order) }
  let(:order) { create(:order) }

  before (:each) do
    allow(controller).to receive(:current_customer) { customer }
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #shopping_cart" do
    it "responds successfully with an HTTP 200 status code" do
      get :shopping_cart
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the shopping_cart template" do
      get :shopping_cart
      expect(response).to render_template("shopping_cart")
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, id: order.id
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the show template" do
      get :show, id: order.id
      expect(response).to render_template("show")
    end
  end

  describe "GET #confirm" do
    it "responds successfully with an HTTP 200 status code" do
      get :confirm, order_id: order.id
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the confirm template" do
      get :confirm, order_id: order.id
      expect(response).to render_template("confirm")
    end
  end

  describe "PATCH update" do 
    it "redirects to the orders_path if order is valid" do
      patch :update, id: order.id, order: attributes_for(:order) 
      response.should redirect_to orders_path 
    end
  end
end
