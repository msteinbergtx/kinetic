class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commission

  validates :amount,
    :payment_date,
    :user,
    :commission,
    presence: true
end
