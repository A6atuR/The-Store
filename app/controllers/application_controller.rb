class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_cart
  
  rescue_from CanCan::AccessDenied do 
    redirect_to root_url
  end

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def current_ability
    @current_ability ||= Ability.new(current_customer)
  end

  private

  def set_cart
    @order = Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    @order = Order.create(state: 'in_progress', delivery_id: Delivery.first.id)
    session[:order_id] = @order.id
  end
end