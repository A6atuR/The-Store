class Order < ActiveRecord::Base
  has_many :order_items
  has_many :coupons
  belongs_to :customer
  belongs_to :delivery
  has_and_belongs_to_many :addresses
  belongs_to :credit_card
  before_save :update_total_price

  state_machine :state, :initial => :in_progress do
    state :in_progress
    state :in_queue
    state :in_delivery
    state :delivered

    event :checkout do
      transition :in_progress => :in_queue
    end
  end

  state_machine.states.map do |state|
    scope state.name, lambda { where(state: state.name.to_s) }
  end

  def update_total_price
    if self.coupons.any?
      self.total_price = self.order_items.map(&:price).sum.to_f * ( 1 - self.coupons.map(&:discount).sum.to_f) + self.delivery.price.to_f
    else 
      self.total_price = self.order_items.map(&:price).sum.to_f + self.delivery.price.to_f 
    end
  end

  def price_without_delivery
    self.order_items.map(&:price).sum.to_f * ( 1 - self.coupons.map(&:discount).sum.to_f)
  end

  def add_book(book_id, params, quantity)
    current_item = order_items.find_by(book_id: book_id)
    if current_item
      current_item.quantity + quantity.to_i
    else
      current_item = order_items.new(params)
    end
    current_item
  end 

  rails_admin do
    edit do
      field :state
    end

    show do
      field :total_price
      field :state
      field :completed_at
      field :customer
      field :address
    end
  end
end