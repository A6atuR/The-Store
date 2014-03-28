class Ability
  include CanCan::Ability

  def initialize(customer)
    can :create, Address 
    can [:update, :edit], Address do |address|
      address.try(:customer) == customer
    end
    can [:index, :show], [Book, Category]
    can :create, CreditCard
    can [:update, :edit], CreditCard do |credit_card|
      credit_card.try(:customer) == customer
    end
    can [:create], OrderItem
    can [:destroy], OrderItem do |order_item|
      order_item.order.try(:customer) == customer
    end
    can [:index, :show, :shopping_cart, :confirm], Order
    can [:update, :edit], Order do |order|
      order.try(:customer) == customer
    end
    can :create, Rating
  end
end