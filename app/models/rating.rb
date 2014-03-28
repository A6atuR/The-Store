class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :customer
  validates_inclusion_of :rating, in: 1..10

  scope :approved, -> { where(status: "approved") }

  state_machine :status, :initial => :not_viewed do
    state :not_viewed
    state :approved
    state :rejected
  end

  rails_admin do
    edit do
      field :status
    end

    show do
      field :rating
      field :text
      field :book
      field :customer
      field :status
    end
  end
end