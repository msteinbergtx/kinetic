class Engine::BasicCompensation < ActiveRecord::Base
  has_one :rule, as: :compensation_engine

  validates :calculation, presence: true

  attr_accessible :calculation

  def compensate(schedule)
    deal = schedule.deal
    rule = schedule.rule
    commission = Commission.new(
      amount: eval(fill_in_real_values(deal)),
      user: deal.user,
      organization: deal.organization,
      payment_date: schedule.commission_payment_date,
      deal: deal,
      rule: rule
    )
    commission.save!
  end

  private

  def fill_in_real_values(deal)
    calculation.gsub(/\[(?<value>.+?)\]/) do |match|
      deal.details.nil? ? '0' : deal.details[$1]
    end
  end
end
