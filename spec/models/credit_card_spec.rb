require 'spec_helper'

describe CreditCard do
  it { should belong_to(:customer) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:cvv) }
  it { should validate_presence_of(:expiration_date) }
end