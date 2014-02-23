class Customer < ActiveRecord::Base
  after_create :create_order
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :ratings
  has_many :orders
  has_many :credit_cards
  # validates :email, :password, :first_name, :last_name, presence: true
  validates :password, length: { in: 8..15 }
  # validates :email, :first_name, :last_name, uniqueness: true

  private

  def create_order
    Order.create(customer_id: self.id, status: "shopping_cart", state: 'in_progress')
  end
end
