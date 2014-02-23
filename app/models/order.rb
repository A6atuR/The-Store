class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :customer
  belongs_to :address
  belongs_to :credit_card
  # validates :total_price, :state, :completed_at, presence: true
  # validates :total_price, numericality: { greater_then: 0 }
  def state_enum
    [['in_progress'],['in_queue'],['in_delivery'],['delivered']]
  end

  def total_price
    order_items.map(&:price).sum
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
      field :status
      field :address
    end
  end
end