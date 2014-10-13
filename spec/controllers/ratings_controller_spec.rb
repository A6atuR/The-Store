require 'controllers/controllers_spec_helper'

describe RatingsController do
  before do
    @customer = create(:customer)
    @order = create(:order)
    allow(controller).to receive(:current_customer) { @customer }
    @book = create(:book)
    redefine_cancan_abilities
  end

  context "POST create" do
    context 'being signed in' do
      before (:each) do
        sign_in @customer
        post :create, book_id: @book.id, rating: attributes_for(:rating) 
      end 

      it "redirects to the book_path if rating is valid" do
        response.should redirect_to book_path(@book)
      end
    end

    context 'being not signed in' do
      before do
        post :create, book_id: @book.id, rating: attributes_for(:rating) 
      end

      it { should redirect_to new_customer_session_path }
    end

    context 'cancan doesnt allow :create' do
      before do
        sign_in @customer
        @ability.cannot :create, Rating
        post :create, book_id: @book.id, rating: attributes_for(:rating) 
      end

      it { should redirect_to root_path }
    end
  end
end