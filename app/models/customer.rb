class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :ratings
  has_many :orders
  has_many :credit_cards
  has_many :addresses

  private

  def self.find_for_facebook_oauth access_token
    if customer = Customer.where(:url => access_token.info.urls.Facebook).first
      customer
    else 
      Customer.create!(:provider => access_token.provider, :url => access_token.info.urls.Facebook, :username => access_token.extra.raw_info.name, :nickname => access_token.extra.raw_info.username, :email => access_token.extra.raw_info.email, :password => Devise.friendly_token[0,15]) 
    end
  end
end