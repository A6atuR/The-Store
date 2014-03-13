require 'spec_helper'

describe Address do
  it { should have_many(:orders) }
  it { should belong_to(:country) }
  it { should belong_to(:customer) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:city) }
end