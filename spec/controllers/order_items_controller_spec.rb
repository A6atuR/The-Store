require 'controllers/controllers_spec_helper'

describe OrderItemsController do
  before do
    @customer = create(:customer)
    @order = create(:order)
    allow(controller).to receive(:current_customer) { @customer }
    @book = create(:book)
    @order_item = create(:order_item)
    redefine_cancan_abilities
  end

  context "POST create" do
    context 'being signed in' do 
      before (:each) do
        sign_in @customer
        post :create, { order_id: @order.id, order_item: attributes_for(:order_item, book_id: @book.id) }
      end
        
      it "redirects to the shopping_cart_path if order_item is valid" do
        response.should redirect_to shopping_cart_path
      end
    end

    context 'being not signed in' do
      before do
        post :create, { order_id: @order.id, order_item: attributes_for(:order_item, book_id: @book.id) }
      end

      it "redirects to the shopping_cart_path if order_item is valid" do
        response.should redirect_to shopping_cart_path
      end
    end

    context 'cancan doesnt allow :create' do
      before do
        sign_in @customer
        @ability.cannot :create, OrderItem
        post :create, { order_id: @order.id, order_item: attributes_for(:order_item, book_id: @book.id) }
      end

      it { should redirect_to root_path }
    end
  end

  context 'DELETE destroy' do
    context 'being signed in' do 
      before (:each) do
        sign_in @customer
        delete :destroy, { order_id: @order.id, id: @order_item.id }
      end

      it "redirects to shopping_cart_path" do 
        expect(response).to redirect_to shopping_cart_path 
      end
    end

    context 'being not signed in' do
      before do
        delete :destroy, { order_id: @order.id, id: @order_item.id }
      end

      it "redirects to shopping_cart_path" do 
        expect(response).to redirect_to shopping_cart_path 
      end
    end

    context 'cancan doesnt allow :destroy' do
      before do
        sign_in @customer
        @ability.cannot :destroy, OrderItem
        delete :destroy, { order_id: @order.id, id: @order_item.id }
      end

      it { should redirect_to root_path }
    end
  end
end