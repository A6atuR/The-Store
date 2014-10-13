require 'spec_helper'

describe Order do
  it { should have_many(:order_items) }
  it { should belong_to(:customer) }
  it { should have_and_belong_to_many(:addresses) }
end