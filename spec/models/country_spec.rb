require 'spec_helper'

describe Country do
  it { should have_many(:addresses) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end