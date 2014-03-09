require 'spec_helper'

describe BooksController do
  let(:customer) { stub_model(Customer, current_order: order) }
  let(:order) { create(:order) }

  describe "GET #index" do
    before (:each) do
      allow(controller).to receive(:current_customer) { customer }
      allow(controller).to receive(:authenticate_customer!)
    end

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

  describe "GET #show" do
    before (:each) do
      allow(controller).to receive(:current_customer) { customer }
      allow(controller).to receive(:authenticate_customer!)
    end

    it "responds successfully with an HTTP 200 status code" do
      get :show, id: create(:book) 
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the #show view" do 
      get :show, id: create(:book) 
      response.should render_template :show 
    end
  end
end