require 'spec_helper'

describe Customer do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should have_many(:ratings) }
  it { should have_many(:addresses) }
  it { should have_many(:orders) }
  it { should have_many(:credit_cards) }
end