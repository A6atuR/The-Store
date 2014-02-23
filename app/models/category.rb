class Category < ActiveRecord::Base
  has_many :books
  validates :title, presence: true
  validates :title, uniqueness: true
end