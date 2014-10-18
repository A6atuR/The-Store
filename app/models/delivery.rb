class Delivery < ActiveRecord::Base
  has_many :orders
  validates :name, :price, presence: true
  validates :price, numericality: true
end
