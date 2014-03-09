class Address < ActiveRecord::Base
  has_many :orders
  belongs_to :country
  validates :address, :zip_code, :city, :phone, presence: true
end
