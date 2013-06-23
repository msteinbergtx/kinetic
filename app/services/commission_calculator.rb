class CommissionCalculator
  def self.calculate(deal)
    deal.commission_schedules.pending_calculation.each do |commission_schedule|
      commission_schedule.calculate_commission
    end
  end
end
