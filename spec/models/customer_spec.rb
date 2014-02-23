require 'spec_helper'

describe Customer do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  # it { should validate_presence_of(:first_name) }
  # it { should validate_presence_of(:last_name) }
  # it { should validate_uniqueness_of(:email) }
  # it { should validate_uniqueness_of(:first_name) }
  # it { should validate_uniqueness_of(:last_name) }
  it { should have_many(:ratings) }
  it { should have_many(:orders) }
  it { should have_many(:credit_cards) }
  it { should ensure_length_of(:password).is_at_least(8).is_at_most(15) }
end