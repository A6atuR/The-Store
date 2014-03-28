require 'spec_helper'

describe Category do
  it { should have_many(:books) }
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }
end