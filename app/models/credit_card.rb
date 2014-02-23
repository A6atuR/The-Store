class CreditCard < ActiveRecord::Base
  belongs_to :customer
  has_many :orders
  validates :number, :cvv, :expiration_month, :expiration_year, presence: true
  validates :number, numericality: true
  validates :number, uniqueness: true
end
