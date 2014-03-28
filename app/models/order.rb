class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :customer
  belongs_to :address
  belongs_to :credit_card

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
      field :address
    end
  end
end