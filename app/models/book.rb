class Book < ActiveRecord::Base
  belongs_to :category
  has_many :ratings
  has_and_belongs_to_many :authors
  has_many :order_items
  validates :title, :price, :in_stock, presence: true
  validates :price, numericality: { greater_then: 0 }
  validates :in_stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, uniqueness: true

  mount_uploader :image, ImageUploader
  paginates_per 3

  rails_admin do
    edit do
      field :title
      field :description
      field :price
      field :in_stock
      field :image
      field :category
    end
  end
end