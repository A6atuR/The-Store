class Ability
  include CanCan::Ability

  def initialize(customer)
    can [:create, :new_shipping, :create_shipping], Address 
    can [:update, :edit], Address do |address|
      address.try(:customer) == customer
    end
    can [:index, :show], [Book, Category]
    can :create, CreditCard
    can [:update, :edit], CreditCard do |credit_card|
      credit_card.try(:customer) == customer
    end
    can [:create, :update, :destroy], OrderItem
    can [:show, :shopping_cart, :empty_cart, :confirm, :update, :new_delivery, :create_delivery, :edit_delivery, :update_delivery], Order
    can [:index, :edit, :complete], Order do |order|
      order.try(:customer) == customer
    end
    can :create, Rating
  end
end