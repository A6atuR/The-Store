require 'spec_helper'

describe Author do
  it { should have_and_belong_to_many(:books) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_uniqueness_of(:first_name) }
  it { should validate_uniqueness_of(:last_name) }
end