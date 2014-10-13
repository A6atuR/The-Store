class Address < ActiveRecord::Base
  has_and_belongs_to_many :orders
  belongs_to :country
  belongs_to :customer
  validates :address, :zip_code, :city, :phone, :first_name, :last_name, :country_id, presence: true
end
