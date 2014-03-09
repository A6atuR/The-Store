require 'spec_helper'

describe Customer do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should have_many(:ratings) }
  it { should have_many(:orders) }
  it { should have_many(:credit_cards) }
  it { should ensure_length_of(:password).is_at_least(8).is_at_most(15) }

  before do
    @customer = FactoryGirl.create(:customer)
    @current_order = @customer.orders.find_by status: "shopping_cart"
  end

  it "creates order with status: shopping_cart after customer sign up" do
    expect(@customer.orders.length).to eq(1)
    expect(@customer.orders.first).to eq(@current_order)
  end

  it "correctly choose current order" do
    @order = FactoryGirl.create(:order, status: "order", customer_id: @customer.id)
    expect(@customer.current_order).to eq(@current_order)
  end  
end