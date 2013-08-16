class Engine::DateOffsetPaymentDate < ActiveRecord::Base
  has_one :rule, as: :payment_date_engine

  validates :event_type, :modifier, :day_count, presence: true
  validates :modifier, inclusion: { in: %w(+ -),
    message: "only +/- are currently supported" }
  validates :event_type, inclusion: { in: %w(start_date end_date),
    message: "only start_date or end_date are currently supported" }

  attr_accessible :event_type, :modifier, :day_count

  def set_date(schedule)
    deal = schedule.deal
    schedule.commission_payment_date = deal.get_datetime(event_type).
      send(self.modifier, self.day_count.days)
    schedule.save!
  end
end
