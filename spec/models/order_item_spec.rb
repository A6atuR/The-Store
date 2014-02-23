require 'spec_helper'

describe OrderItem do
  it { should belong_to(:order) }
  it { should belong_to(:book) }
  # it { should validate_presence_of(:price) }
  # it { should validate_presence_of(:quantity) }
  # it { should validate_numericality_of(:price) }
  it { should validate_numericality_of(:quantity).only_integer }
end