class Address < ActiveRecord::Base
  has_many :orders
  belongs_to :country
  belongs_to :customer
  validates :address, :zip_code, :city, :phone, presence: true
end
