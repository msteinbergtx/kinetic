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
end
