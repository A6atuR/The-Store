require 'spec_helper'

describe Book do
  it { should have_and_belong_to_many(:authors) }
  it { should have_many(:ratings) }
  it { should belong_to(:category) }
  it { should have_many(:order_items) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:in_stock) }
  it { should validate_numericality_of(:price) }
  it { should validate_numericality_of(:in_stock).only_integer }
  it { should validate_uniqueness_of(:title) }
end