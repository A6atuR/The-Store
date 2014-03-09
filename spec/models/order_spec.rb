require 'spec_helper'

describe Order do
  before do
    @order = FactoryGirl.create(:order)
    @book = FactoryGirl.create(:book)
    @order_item_1 = FactoryGirl.create(:order_item, order_id: @order.id, book_id: @book.id)
    @order_item_2 = FactoryGirl.create(:order_item_2, order_id: @order.id, book_id: @book.id)
  end

  it "updates total_price of order" do
    expect(@order.update_attribute(:total_price, @order.total_price)).to eq(true)
  end

  it { should have_many(:order_items) }
  it { should belong_to(:customer) }
  it { should belong_to(:address) }
end