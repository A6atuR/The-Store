class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book
  after_create :update_price
  # validates :price, :quantity, presence: true
  # validates :price, numericality: { greater_then: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  private

  def update_price
    update_attribute(:price, book.price * quantity)
  end
end