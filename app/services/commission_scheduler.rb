class CommissionScheduler
  def self.schedule_payment_date(schedule)
    schedule.set_payment_date
  end

  def self.schedule_calculation_date(schedule)
    schedule.set_calculation_date
  end
end
