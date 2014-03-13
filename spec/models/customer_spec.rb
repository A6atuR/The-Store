require 'spec_helper'
require "cancan/matchers"

describe Customer do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should have_many(:ratings) }
  it { should have_many(:addresses) }
  it { should have_many(:orders) }
  it { should have_many(:credit_cards) }
  it { should ensure_length_of(:password).is_at_least(8).is_at_most(15) }

  before do
    @customer = FactoryGirl.create(:customer)
    @current_order = @customer.orders.find_by state: "in_progress"
  end

  it "creates order with state: in_progress after customer sign up" do
    expect(@customer.orders.length).to eq(1)
    expect(@customer.orders.first).to eq(@current_order)
  end

  it "correctly choose current order" do
    @order = FactoryGirl.create(:order, state: "delivered", customer_id: @customer.id)
    expect(@customer.current_order).to eq(@current_order)
  end  

  describe 'abilities' do
    let(:customer) { create(:customer) }
    let(:order) { customer.orders.in_progress.first }
    subject(:ability) { Ability.new(customer) }

    it { should be_able_to :show, build(:book) }
    it { should be_able_to :index, build(:book) }
    it { should be_able_to :show, build(:category) }
    it { should be_able_to :index, build(:category) }
    it { should be_able_to :create, build(:credit_card) }
    it { should be_able_to :update, build(:credit_card, customer_id: customer.id) }
    it { should be_able_to :edit, build(:credit_card, customer_id: customer.id) }
    it { should be_able_to :create, build(:address) }
    it { should be_able_to :update, build(:address, customer_id: customer.id) }
    it { should be_able_to :edit, build(:address, customer_id: customer.id) }
    it { should be_able_to :create, build(:order_item) }
    it { should be_able_to :destroy, build(:order_item, order_id: order.id) }
    it { should be_able_to :show, build(:order) }
    it { should be_able_to :index, build(:order) }
    it { should be_able_to :confirm, build(:order) }
    it { should be_able_to :shopping_cart, build(:order) }
    it { should be_able_to :update, build(:order, customer_id: customer.id) }
    it { should be_able_to :edit, build(:order, customer_id: customer.id) }
    it { should be_able_to :create, build(:rating) }
  end
end