class Rule < ActiveRecord::Base
  belongs_to :applicability_engine, polymorphic: true
  belongs_to :calculation_date_engine, polymorphic: true
  belongs_to :compensation_engine, polymorphic: true
  belongs_to :payment_date_engine, polymorphic: true
  belongs_to :organization

  has_many :commission_schedules
  has_many :deals, through: :commission_schedules

  validates :name, presence: true
  validates :active, inclusion: { in: [true, false] }

  accepts_nested_attributes_for :applicability_engine,
    :calculation_date_engine,
    :compensation_engine,
    :payment_date_engine

  def self.deactivated
    where(active: false)
  end

  def self.live
    date_time_where = <<-SQL
start_date IS NULL AND end_date IS NULL OR
start_date <= ? AND end_date >= ? OR
start_date IS NULL AND end_date >= ? OR
start_date <= ? AND end_date is NULL
    SQL
    current_time = Time.now
    where(active: true).
      where(
        date_time_where,
        current_time,
        current_time,
        current_time,
        current_time
      )
  end

  def mutable?
    deals.count == 0
  end
end
