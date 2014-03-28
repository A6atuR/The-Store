require 'spec_helper'
require "cancan/matchers"

describe Customer do
  let(:customer) { create(:customer) }
  let(:order) { customer.orders.in_progress.first }
  subject(:ability) { Ability.new(customer) }

  it { should be_able_to :show, build(:book) }
  it { should be_able_to :index, build(:book) }
  it { should be_able_to :show, build(:category) }
  it { should be_able_to :index, build(:category) }
  it { should be_able_to :create, build(:credit_card) }
  it { should be_able_to :update, build(:credit_card, customer_id: customer.id) }
  it { should_not be_able_to :update, build(:credit_card) }
  it { should be_able_to :edit, build(:credit_card, customer_id: customer.id) }
  it { should_not be_able_to :edit, build(:credit_card) }
  it { should be_able_to :create, build(:address) }
  it { should be_able_to :update, build(:address, customer_id: customer.id) }
  it { should_not be_able_to :update, build(:address) }
  it { should be_able_to :edit, build(:address, customer_id: customer.id) }
  it { should_not be_able_to :edit, build(:address) }
  it { should be_able_to :create, build(:order_item) }
  it { should be_able_to :destroy, build(:order_item, order_id: order.id) }
  it { should_not be_able_to :destroy, build(:order_item) }
  it { should be_able_to :show, build(:order) }
  it { should be_able_to :index, build(:order) }
  it { should be_able_to :confirm, build(:order) }
  it { should be_able_to :shopping_cart, build(:order) }
  it { should be_able_to :update, build(:order, customer_id: customer.id) }
  it { should_not be_able_to :update, build(:order) }
  it { should be_able_to :edit, build(:order, customer_id: customer.id) }
  it { should_not be_able_to :edit, build(:order) }
  it { should be_able_to :create, build(:rating) }
end