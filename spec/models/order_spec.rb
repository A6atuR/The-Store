require 'spec_helper'

describe Order do
  it { should have_many(:order_items) }
  it { should belong_to(:customer) }
  it { should belong_to(:address) }
  # it { should validate_presence_of(:total_price) }
  # it { should validate_presence_of(:state) }
  # it { should validate_presence_of(:completed_at) }
  # it { should validate_numericality_of(:total_price) }
end