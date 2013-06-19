class Commission < ActiveRecord::Base
  belongs_to :user

  validates :user, :payment_date, :amount, presence: true
end
