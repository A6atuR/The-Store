require 'spec_helper'

describe OrderItem do
  let(:order_item) { create(:order_item, book_id: book.id) }
  let(:book) { create(:book) }

  it "calculates correctly price of order_item" do
    order_item.send(:update_price)
    expect(order_item.price).to eq(400)
  end

  it { should belong_to(:order) }
  it { should belong_to(:book) }
  it { should validate_numericality_of(:quantity).only_integer }
end