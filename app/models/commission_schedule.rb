class CommissionSchedule < ActiveRecord::Base
  belongs_to :deal
  belongs_to :rule

  validates :deal, :rule, presence: true

  attr_accessible :deal, :rule

  def self.pending_calculation
    where(
      'commission_calculated_date is ? AND calculate_commission_date <= ?',
      nil,
      Time.now
    )
  end

  def set_calculation_date
    rule.calculation_date_engine.set_date(self)
  end

  def set_payment_date
    rule.payment_date_engine.set_date(self)
  end

  def calculate_commission
    rule.compensation_engine.compensate(self)
    self.commission_calculated_date = Time.now
    self.save!
  end

  def commission_calculated?
    self.commission_calculated_date.present?
  end
end
