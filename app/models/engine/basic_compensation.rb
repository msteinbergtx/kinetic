class Engine::BasicCompensation < ActiveRecord::Base
  has_one :rule, as: :compensation_engine

  validates :calculation, presence: true

  attr_accessible :calculation

  def compensate(schedule)
    deal = schedule.deal
    rule = schedule.rule
    eval_calculation = calculation.gsub(/\[amount\]/, deal.amount.to_s)
    calculation.gsub!(/[A-Za-z]/, '')
    commission = Commission.new(
      amount: eval(eval_calculation),
      user: deal.user,
      organization: deal.organization,
      payment_date: schedule.commission_payment_date,
      deal: deal,
      rule: rule
    )
    commission.save!
  end
end
