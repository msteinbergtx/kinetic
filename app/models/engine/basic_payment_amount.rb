class Engine::BasicPaymentAmount < ActiveRecord::Base
  has_one :rule, as: :payment_amount_engine

  validates :calculation, presence: true

  attr_accessible :calculation
end
