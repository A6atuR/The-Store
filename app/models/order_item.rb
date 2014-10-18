class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book
  before_save :update_price
  after_save :update_order_total_price
  after_destroy :update_order_total_price
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  private

  def update_price
    self.price = self.book.price * self.quantity
  end

  def update_order_total_price
    self.order.update_total_price
  end
end