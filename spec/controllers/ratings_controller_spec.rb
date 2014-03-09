require 'spec_helper'

describe RatingsController do
  describe "POST create" do 
    let(:customer) { stub_model(Customer) }

    before (:each) do
      allow(controller).to receive(:current_customer) { customer }
      @book = create(:book)
    end
      
    it "redirects to the book_path if rating is valid" do
      post :create, book_id: @book.id, rating: attributes_for(:rating) 
      response.should redirect_to book_path(@book)
    end
  end
end
