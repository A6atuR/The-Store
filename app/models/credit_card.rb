class CreditCard < ActiveRecord::Base
  belongs_to :customer
  has_many :orders
  validates :number, :cvv, :expiration_date, presence: true
end
