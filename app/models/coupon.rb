class Coupon < ActiveRecord::Base
  belongs_to :order
  validates :code, :discount, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 8 }
  validates :code, numericality: { only_integer: true }
  validates :discount, inclusion: 0..1
end