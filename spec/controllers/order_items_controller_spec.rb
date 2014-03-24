require 'spec_helper'

describe OrderItemsController do
  let(:order) { @customer.orders.first }
  let(:book) { create(:book) }
  let(:order_item) { create(:order_item, order_id: order.id) }

  describe "POST create" do 
    before (:each) do
      @customer = create(:customer)
      allow(controller).to receive(:current_customer) { @customer }
    end
      
    it "redirects to the shopping_cart_path if order_item is valid" do
      post :create, { order_id: order.id, order_item: attributes_for(:order_item, book_id: book.id) }
      response.should redirect_to shopping_cart_path
    end
  end

  describe 'DELETE destroy' do
    before (:each) do
      @customer = create(:customer)
      allow(controller).to receive(:current_customer) { @customer }
    end

    it "redirects to shopping_cart_path if order item belongs to customers current order" do 
      delete :destroy, { order_id: order.id, id: order_item.id }
      expect(response).to redirect_to shopping_cart_path 
    end

    it "redirects to root url if order item not belongs to customers current order" do
      @order_item = create(:order_item)
      delete :destroy, { order_id: order.id, id: @order_item.id }
      expect(response).to redirect_to root_url
    end
  end
end