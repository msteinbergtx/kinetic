class Engine::DateOffsetCalculationDate < ActiveRecord::Base
  has_one :rule, as: :calculation_date_engine

  validates :event_type, :modifier, :day_count, presence: true
  validates :modifier, inclusion: { in: %w(+ -),
        message: "only +/- are currently supported" }

  attr_accessible :event_type, :modifier, :day_count
end
