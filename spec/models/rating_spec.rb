require 'spec_helper'

describe Rating do
  it { should belong_to(:customer) }
  it { should belong_to(:book) }
  it { should ensure_inclusion_of(:rating).in_range(1..10) }
end