require 'spec_helper'

describe OrderItemsController do
  let(:customer) { stub_model(Customer, current_order: order) }
  let(:order) { create(:order) }
  let(:book) { create(:book) }
  let(:order_item) { create(:order_item, order_id: order.id) }

  describe "POST create" do 
    before (:each) do
      allow(controller).to receive(:current_customer) { customer }
    end
      
    it "redirects to the shopping_cart_path if order_item is valid" do
      post :create, { order_id: order.id, order_item: attributes_for(:order_item, book_id: book.id) }
      response.should redirect_to shopping_cart_path
    end
  end

  describe 'DELETE destroy' do
    it "redirects to shopping_cart_path" do 
      delete :destroy, { order_id: order.id, id: order_item.id }
      expect(response).to redirect_to shopping_cart_path 
    end
  end
end
