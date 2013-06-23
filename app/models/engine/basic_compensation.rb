class Engine::BasicCompensation < ActiveRecord::Base
  has_one :rule, as: :compensation_engine

  validates :calculation, presence: true

  attr_accessible :calculation

  def compensate(schedule)
    deal = schedule.deal
    rule = schedule.rule
    arguments = calculation.split(',')
    arguments[1] = BigDecimal(arguments[1])
    commission = Commission.new(
      amount: deal.amount.send(*arguments),
      user: deal.user,
      organization: deal.organization,
      payment_date: schedule.commission_payment_date,
      deal: deal,
      rule: rule
    )
    commission.save!
  end
end
